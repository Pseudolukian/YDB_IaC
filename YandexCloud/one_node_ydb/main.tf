#========== Provider initializing zone =============
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

#============== Auth zone ================
provider "yandex" {
  service_account_key_file = var.key_path
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone_name
}

#============== NET disk create zone =========
resource "yandex_compute_disk" "ydb-disk" {
  count = 3
  name = "${var.attache_disk_name}-${count.index + 1}"
  size = var.attache_disk_size
  type = var.attache_disk_type
  zone = var.zone_name

  disk_placement_policy {
    disk_placement_group_id = yandex_compute_disk_placement_group.ydb-placement-group.id
  }
}

resource "yandex_compute_disk_placement_group" "ydb-placement-group" {
  name = var.attache_disk_placement
  zone = var.zone_name
}

#============ VM create zone ========
resource "yandex_compute_instance" "ydb-3-node" {
  platform_id = var.vps_platform
  name  = var.vps_name
  zone  = var.zone_name
  allow_stopping_for_update = true

  resources {
    cores  = var.cores
    memory = var.memory
  }

  boot_disk {
    initialize_params {
      image_id = var.os_image_id
      size = var.storage_size
      type = var.storage_type_ssd
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.ydb-disk.*.id
    content {
      disk_id = secondary_disk.value
      device_name = "${var.attache_disk_name}-${secondary_disk.key}"
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_key_pub_path)}"
  }

}

output "vm_public_ips" {
  value = yandex_compute_instance.ydb-3-node.network_interface.0.nat_ip_address
}

resource "local_file" "hosts" {
  content = <<-EOF
    [ydb-server]
    ${yandex_compute_instance.ydb-3-node.network_interface.0.nat_ip_address} ansible_ssh_user=${var.user} ansible_ssh_private_key_file=${var.ssh_key_private_path} ansible_ssh_common_args='-o StrictHostKeyChecking=no'
    EOF

  filename = "./hosts"
}
#======== Auth setup zone ===========#
key_path = "../../auth_key.json"                    // Set the JSON SA key file
cloud_id = "b1gv7kfcttiop2s874m6"                   // Yandex WEB GUI Cloud 
folder_id = "b1gd9ii2bbihondqoibt"                  // Yandex folder ID
zone_name = "ru-central1-a"                         // Yandex zone name

#======= VM setup zone ============#
vps_platform = "standard-v1"                        // standard-v1 – Intel Broadwell, -v2 – Intel Cascade Lake, -v3 – Intel Ice Lake.
vps_name = "ydb-3-node-base"                        // Virtual machine name
cores = 8                                           //vCPU (2, 4, 6, 8, 10, 12, 14, 16, 20, 24, 28, 32)                        
memory = 16                                          // Memory, GB (4GB, 8GB, 12GB, 16GB, 20GB, 24GB, 28GB, 32GB.)
os_image_id = "fd8clogg1kull9084s9o"                // Ubuntu 20.04 image
storage_size = 80                                   // The min disk size (GB)
storage_type_ssd = "network-ssd"                    // Storage type
subnet_id = "e9bmliplcipm13ek7uco"                  // Subnet ID

#======= NET disk zone =============#
attache_disk_name = "ydb-disk"                      // Disk name
attache_disk_size = 93                              // NB size must be divisible by 93 (GB)
attache_disk_type = "network-ssd-nonreplicated"     // Type of the NET disk
attache_disk_placement = "ydb-placement-group"      // Placement group name

#====== SSH credentials zone =======#
user = "ubuntu"                                     // Username to connect via SSH
ssh_key_pub_path = "~/yandex.pub"                   // Path to public part of SSH-key
ssh_key_private_path = "~/yandex"                   // Path to private part of SSH-key
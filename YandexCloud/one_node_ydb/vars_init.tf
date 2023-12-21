#============ Auth vars initializing ================
variable "key_path"                  {type = string}
variable "cloud_id"                  {type = string}
variable "folder_id"                 {type = string}

#============= VM vars initializing =================
variable "vps_platform"              {type = string}
variable "zone_name"                 {type = string}
variable "vps_name"                  {type = string}
variable "cores"                     {type = number}
variable "memory"                    {type = number}
variable "os_image_id"               {type = string}
variable "storage_size"              {type = string}
variable "subnet_id"                 {type = string}
variable "storage_type_ssd"          {type = string}

#====== SSH conn. vars initializing ================
variable "user"                     {type = string}
variable "ssh_key_pub_path"         {type = string}
variable "ssh_key_private_path"     {type = string}

#======= NET disk vars initializing ===============
variable "attache_disk_name"        {type = string}
variable "attache_disk_size"        {type = number}
variable "attache_disk_type"        {type = string}
variable "attache_disk_placement"   {type = string}
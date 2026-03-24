### Cloud variables
variable "token_path" {
  type        = string
  description = "Path to service account key file"
}

variable "cloud_id" {
  type        = string
  description = "Cloud ID"
}

variable "folder_id" {
  type        = string
  description = "Folder ID"
}

variable "default_zone" {
  type        = string
  description = "Default availability zone"
}

variable "default_cidr" {
  type        = list(string)
  description = "CIDR block for subnet"
}

variable "vpc_name" {
  type        = string
  description = "VPC network name"
}

### SSH variables
variable "vms_ssh_root_key_path" {
  type        = string
  description = "Path to SSH public key"
}

### OS Image variables
variable "image_family" {
  type        = string
  description = "Family of the OS image"
}

variable "boot_disk_size" {
  type        = number
  description = "Boot disk size in GB"
  
  validation {
    condition     = var.boot_disk_size >= 10
    error_message = "Boot disk size must be at least 10 GB."
  }
}

### Web servers variables (count)
variable "web_instances" {
  description = "Web servers configuration"
  type = object({
    count          = number
    platform_id    = string
    cpu            = number
    ram            = number
    core_fraction  = number
    preemptible    = bool
    disk_size      = number
  })
}

### Database servers variables (for_each)
variable "database_instances" {
  description = "Database instances configuration"
  type = list(object({
    vm_name       = string
    platform_id   = string
    cpu           = number
    ram           = number
    core_fraction = number
    disk_volume   = number
    preemptible   = bool
  }))
}

### Storage server variables
variable "storage_instance" {
  description = "Storage server configuration"
  type = object({
    name           = string
    platform_id    = string
    cpu            = number
    ram            = number
    core_fraction  = number
    preemptible    = bool
    boot_disk_size = number
  })
}

variable "storage_disks" {
  description = "Additional storage disks configuration"
  type = object({
    count      = number
    type       = string
    size       = number
  })
  
  validation {
    condition     = var.storage_disks.size >= 1
    error_message = "Additional disk size must be at least 1 GB."
  }
}

### Security group variables
variable "security_group_ingress" {
  description = "Ingress security rules"
  type = list(object({
    protocol       = string
    description    = string
    v4_cidr_blocks = list(string)
    port           = optional(number)
    from_port      = optional(number)
    to_port        = optional(number)
  }))
}

variable "security_group_egress" {
  description = "Egress security rules"
  type = list(object({
    protocol       = string
    description    = string
    v4_cidr_blocks = list(string)
    port           = optional(number)
    from_port      = optional(number)
    to_port        = optional(number)
  }))
}

### Ansible inventory variables
variable "inventory_template_path" {
  type        = string
  description = "Path to Ansible inventory template"
  default     = "inventory.tftpl"
}
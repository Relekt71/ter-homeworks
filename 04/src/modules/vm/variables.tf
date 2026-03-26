variable "name" {
  description = "VM name"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "username" {
  description = "Username for VM"
  type        = string
  default     = "ubuntu"
}

variable "ssh_key" {
  description = "SSH public key"
  type        = string
  sensitive   = true
}

variable "zone" {
  description = "Availability zone"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "image_id" {
  description = "OS image ID"
  type        = string
}

variable "platform_id" {
  description = "Platform ID"
  type        = string
  default     = "standard-v2"
}

variable "cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 2
}

variable "memory" {
  description = "Memory in GB"
  type        = number
  default     = 2
}

variable "disk_size" {
  description = "Disk size in GB"
  type        = number
  default     = 10
}

variable "nat_enabled" {
  description = "Enable NAT for VM"
  type        = bool
  default     = true
}

variable "core_fraction" {
  description = "Core fraction for VM (5-100)"
  type        = number
  default     = 100
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
  default     = []
}

variable "nginx_port" {
  description = "Nginx port"
  type        = number
  default     = 80
}

variable "labels" {
  description = "Resource labels"
  type        = map(string)
  default     = {}
}
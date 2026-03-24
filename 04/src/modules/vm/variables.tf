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
  description = "SSH public key content"
  type        = string
  sensitive   = true
}

variable "zone" {
  description = "Availability zone"
  type        = string
  default     = "ru-central1-a"
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "image_id" {
  description = "OS image ID"
  type        = string
  default     = "fd8kipad7p3bcne5l2bj"
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

variable "labels" {
  description = "Resource labels"
  type        = map(string)
  default     = {}
}
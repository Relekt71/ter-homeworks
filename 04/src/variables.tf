variable "service_account_key_file" {
  description = "Path to service account key file (JSON)"
  type        = string
  sensitive   = true
  default     = "/home/relekt/tokens/token.json"
}

variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
  sensitive   = true
  default     = "b1gecg7g9vaf2vm3jlbv"
}

variable "folder_id" {
  description = "Yandex Cloud folder ID"
  type        = string
  sensitive   = true
  default     = "b1gi7d9oo4tihh61hkeb"
}

variable "zone" {
  description = "Availability zone"
  type        = string
  default     = "ru-central1-a"
}

variable "vm_username" {
  description = "Username for VMs"
  type        = string
  default     = "ubuntu"
}

variable "ssh_key_path" {
  description = "Path to SSH public key file"
  type        = string
  default     = "/home/relekt/github.pub"
}

variable "vpc_name" {
  description = "VPC network name"
  type        = string
  default     = "develop"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.1.0/24"
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
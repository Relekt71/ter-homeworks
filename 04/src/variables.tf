# variables.tf
variable "service_account_key_file" {
  description = "Path to service account key file (JSON)"
  type        = string
  default     = "/home/relekt/tokens/token.json"
}

variable "vms_ssh_root_key_path" {
  description = "Path to SSH public key file"
  type        = string
  default     = "/home/relekt/github.pub"
}

variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud folder ID"
  type        = string
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

variable "vpc_name" {
  description = "VPC network name"
  type        = string
  default     = "develop"
}
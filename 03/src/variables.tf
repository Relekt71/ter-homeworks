###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
  default = "/home/relekt/tokens/token.json"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "token_path" {
  type        = string
  description = "Token Path"
}

variable "vms_ssh_root_key_path" {
  type        = string
  description = "SSH Key"
}

variable "each_vm" {
  description = "Configuration for database VMs"
  type = list(object({
    vm_name       = string
    cpu           = number
    ram           = number
    disk_volume   = number
    platform_id   = optional(string, "standard-v3")
    core_fraction = optional(number, 20)
    preemptible   = optional(bool, true)
    image_id      = optional(string, "fd80rt9kfkrpsq4dh9c9")
  }))
  default = [
    {
      vm_name     = "main"
      cpu         = 2
      ram         = 4
      disk_volume = 20
    },
    {
      vm_name     = "replica"
      cpu         = 4
      ram         = 8
      disk_volume = 30
    }
  ]
}
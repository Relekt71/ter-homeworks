variable "service_account_key_file" {
  description = "Path to service account key file (JSON)"
  type        = string
  default     = "/home/relekt/tokens/token.json"
}

variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud folder ID"
  type        = string
}
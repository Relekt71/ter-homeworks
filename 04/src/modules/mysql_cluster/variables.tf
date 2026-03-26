variable "cluster_name" {
  description = "Name of the MySQL cluster"
  type        = string
}

variable "environment" {
  description = "Environment (PRESTABLE, PRODUCTION)"
  type        = string
  default     = "PRESTABLE"
}

variable "network_id" {
  description = "ID of the VPC network"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for hosts"
  type = list(object({
    id   = string
    zone = string
  }))
}

variable "ha_enabled" {
  description = "Enable High Availability"
  type        = bool
  default     = false
}

variable "mysql_version" {
  description = "MySQL version"
  type        = string
  default     = "8.0"
}

variable "resource_preset_id" {
  description = "Resource preset ID"
  type        = string
  default     = "s2.micro"
}

variable "disk_type_id" {
  description = "Disk type ID"
  type        = string
  default     = "network-ssd"
}

variable "disk_size" {
  description = "Disk size in GB"
  type        = number
  default     = 10
}

variable "backup_window_hours" {
  description = "Backup window start hour"
  type        = number
  default     = 1
}

variable "backup_window_minutes" {
  description = "Backup window start minute"
  type        = number
  default     = 0
}

variable "backup_retain_period" {
  description = "Backup retain period in days"
  type        = number
  default     = 7
}

variable "labels" {
  description = "Labels for the cluster"
  type        = map(string)
  default     = {}
}
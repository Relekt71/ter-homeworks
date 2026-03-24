variable "cluster_name" {
  description = "Name of the MySQL cluster"
  type        = string
}

variable "environment" {
  description = "Environment (PRODUCTION or PRESTABLE)"
  type        = string
  default     = "PRESTABLE"
}

variable "network_id" {
  description = "ID of the VPC network"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet"
  type        = string
}

variable "zone" {
  description = "Availability zone"
  type        = string
  default     = "ru-central1-a"
}

variable "ha" {
  description = "High availability mode"
  type        = bool
  default     = false
}

variable "mysql_version" {
  description = "MySQL version"
  type        = string
  default     = "8.0"
}

variable "resource_preset_id" {
  description = "Resource preset"
  type        = string
  default     = "b2.medium"
}

variable "disk_type_id" {
  description = "Disk type"
  type        = string
  default     = "network-hdd"
}

variable "disk_size" {
  description = "Disk size in GB"
  type        = number
  default     = 10
}
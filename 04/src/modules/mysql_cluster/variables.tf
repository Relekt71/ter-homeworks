variable "cluster_name" {
  description = "Name of the MySQL cluster"
  type        = string
}

variable "environment" {
  description = "Environment (PRODUCTION or PRESTABLE)"
  type        = string
  default     = "PRESTABLE"
  
  validation {
    condition     = contains(["PRODUCTION", "PRESTABLE"], var.environment)
    error_message = "Environment must be either PRODUCTION or PRESTABLE."
  }
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
  description = "High availability mode (true = 2 hosts, false = 1 host)"
  type        = bool
  default     = false
}

variable "mysql_version" {
  description = "MySQL version"
  type        = string
  default     = "8.0"
  
  validation {
    condition     = contains(["5.7", "8.0"], var.mysql_version)
    error_message = "MySQL version must be either 5.7 or 8.0."
  }
}

variable "resource_preset_id" {
  description = "Resource preset (b2.medium, s2.micro, etc.)"
  type        = string
  default     = "b2.medium"
}

variable "disk_type_id" {
  description = "Disk type (network-ssd, network-hdd)"
  type        = string
  default     = "network-hdd"
}

variable "disk_size" {
  description = "Disk size in GB"
  type        = number
  default     = 10
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
  default     = []
}

variable "backup_hour_start" {
  description = "Backup start hour"
  type        = number
  default     = 1
}

variable "backup_minute_start" {
  description = "Backup start minute"
  type        = number
  default     = 0
}

variable "access_data_lens" {
  description = "Allow access from DataLens"
  type        = bool
  default     = false
}

variable "access_web_sql" {
  description = "Allow access from Web SQL"
  type        = bool
  default     = false
}

variable "access_data_transfer" {
  description = "Allow access from Data Transfer"
  type        = bool
  default     = false
}

variable "performance_diagnostics_enabled" {
  description = "Enable performance diagnostics"
  type        = bool
  default     = false
}

variable "sessions_sampling_interval" {
  description = "Sessions sampling interval"
  type        = number
  default     = 60
}

variable "statements_sampling_interval" {
  description = "Statements sampling interval"
  type        = number
  default     = 60
}
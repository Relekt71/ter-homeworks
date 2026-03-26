# ============================================
# Общие переменные
# ============================================

variable "service_account_key_file" {
  description = "Path to service account key file"
  type        = string
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
  description = "Default availability zone"
  type        = string
  default     = "ru-central1-a"
}

variable "common_labels" {
  description = "Common labels for all resources"
  type        = map(string)
  default = {
    managed_by = "terraform"
    owner      = "devops"
  }
}

# ============================================
# Задание 2 и 4*: VPC переменные
# ============================================

variable "vpc_dev_name" {
  description = "Development VPC name"
  type        = string
  default     = "develop"
}

variable "vpc_dev_subnets" {
  description = "Subnets for development VPC"
  type = list(object({
    zone = string
    cidr = string
  }))
  default = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" }
  ]
}

variable "vpc_prod_name" {
  description = "Production VPC name"
  type        = string
  default     = "production"
}

variable "vpc_prod_subnets" {
  description = "Subnets for production VPC"
  type = list(object({
    zone = string
    cidr = string
  }))
  default = [
    { zone = "ru-central1-a", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.3.0/24" },
    { zone = "ru-central1-d", cidr = "10.0.4.0/24" }
  ]
}

# ============================================
# Задание 1: VM переменные
# ============================================

variable "marketing_vm_name" {
  description = "Marketing VM name"
  type        = string
  default     = "marketing-vm"
}

variable "analytics_vm_name" {
  description = "Analytics VM name"
  type        = string
  default     = "analytics-vm"
}

variable "vm_username" {
  description = "Username for VMs"
  type        = string
  default     = "ubuntu"
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key file"
  type        = string
}

variable "vm_image_id" {
  description = "OS image ID for VMs"
  type        = string
  default     = "fd8kipad7p3bcne5l2bj"
}

variable "vm_platform_id" {
  description = "Platform ID for VMs"
  type        = string
  default     = "standard-v2"
}

variable "vm_cores" {
  description = "Number of CPU cores for VMs"
  type        = number
  default     = 2
}

variable "vm_memory" {
  description = "Memory in GB for VMs"
  type        = number
  default     = 2
}

variable "vm_disk_size" {
  description = "Disk size in GB for VMs"
  type        = number
  default     = 10
}

variable "vm_core_fraction" {
  description = "Core fraction for VMs (5-100)"
  type        = number
  default     = 100
}

# ============================================
# Задание 5*: MySQL переменные
# ============================================

variable "mysql_cluster_name" {
  description = "Name of the MySQL cluster"
  type        = string
  default     = "example-mysql-cluster"
}

variable "mysql_environment" {
  description = "Environment for MySQL cluster"
  type        = string
  default     = "PRESTABLE"
}

variable "mysql_ha_enabled" {
  description = "Enable High Availability"
  type        = bool
  default     = false
}

variable "mysql_version" {
  description = "MySQL version"
  type        = string
  default     = "8.0"
}

variable "mysql_resource_preset_id" {
  description = "Resource preset for MySQL hosts"
  type        = string
  default     = "s2.micro"
}

variable "mysql_disk_type_id" {
  description = "Disk type for MySQL"
  type        = string
  default     = "network-ssd"
}

variable "mysql_disk_size" {
  description = "Disk size in GB for MySQL"
  type        = number
  default     = 10
}

variable "mysql_backup_window_hours" {
  description = "Backup window start hour"
  type        = number
  default     = 1
}

variable "mysql_backup_window_minutes" {
  description = "Backup window start minute"
  type        = number
  default     = 0
}

variable "mysql_backup_retain_period" {
  description = "Backup retain period in days"
  type        = number
  default     = 7
}

variable "mysql_database_name" {
  description = "Name of the database"
  type        = string
  default     = "testdb"
}

variable "mysql_user_name" {
  description = "Name of the database user"
  type        = string
  default     = "appuser"
}

variable "mysql_user_password" {
  description = "Password for the database user"
  type        = string
  sensitive   = true
}

variable "mysql_user_roles" {
  description = "Roles for the database user"
  type        = list(string)
  default     = ["ALL"]
}
# ============================================
# Секретные переменные (из secrets.auto.tfvars)
# ============================================
variable "service_account_key_file" {
  description = "Path to service account key file (JSON)"
  type        = string
  sensitive   = true
}

variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
  sensitive   = true
}

variable "folder_id" {
  description = "Yandex Cloud folder ID"
  type        = string
  sensitive   = true
}

# ============================================
# Общие переменные (из terraform.tfvars)
# ============================================
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
  default     = "~/.ssh/id_rsa.pub"
}

variable "image_id" {
  description = "OS image ID (Ubuntu 20.04)"
  type        = string
  default     = "fd8kipad7p3bcne5l2bj"
}

variable "platform_id" {
  description = "Platform ID"
  type        = string
  default     = "standard-v2"
}

# ============================================
# Переменные для VPC (Задания 1-3)
# ============================================
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

# ============================================
# Переменные для MySQL (Задание 5*)
# ============================================
variable "mysql_cluster_name" {
  description = "MySQL cluster name"
  type        = string
  default     = "example-mysql-cluster"
}

variable "mysql_ha" {
  description = "High availability mode for MySQL"
  type        = bool
  default     = false
}

variable "mysql_database_name" {
  description = "MySQL database name"
  type        = string
  default     = "testdb"
}

variable "mysql_username" {
  description = "MySQL username"
  type        = string
  default     = "appuser"
}

variable "mysql_resource_preset" {
  description = "MySQL resource preset"
  type        = string
  default     = "b2.medium"
}

variable "mysql_disk_size" {
  description = "MySQL disk size in GB"
  type        = number
  default     = 10
}

variable "mysql_version" {
  description = "MySQL version"
  type        = string
  default     = "8.0"
}
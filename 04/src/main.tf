terraform {
  required_version = ">= 1.0"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.87"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

locals {
  service_account_key = file(var.service_account_key_file)
  ssh_key             = file(var.vms_ssh_root_key_path)
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                  = var.cloud_id
  folder_id                 = var.folder_id
  zone                      = var.zone
}

# Генерируем случайный пароль
resource "random_password" "mysql_password" {
  length  = 16
  special = false
  numeric = true
  upper   = true
  lower   = true
}

# Создаем новую VPC сеть для MySQL кластера
resource "yandex_vpc_network" "mysql_network" {
  name        = "mysql-network"
  description = "Network for MySQL cluster"
  
  labels = {
    environment = "dev"
    managed_by  = "terraform"
    purpose     = "mysql-cluster"
  }
}

# Создаем подсеть для MySQL кластера
resource "yandex_vpc_subnet" "mysql_subnet" {
  name           = "mysql-subnet"
  description    = "Subnet for MySQL cluster"
  zone           = var.zone
  network_id     = yandex_vpc_network.mysql_network.id
  v4_cidr_blocks = ["10.2.0.0/24"]
  
  labels = {
    environment = "dev"
    managed_by  = "terraform"
    purpose     = "mysql-cluster"
  }
}

# Создаем MySQL кластер с одним хостом
module "mysql_cluster" {
  source = "./modules/mysql_cluster"
  
  cluster_name = "example-mysql-cluster"
  environment  = "PRESTABLE"
  network_id   = yandex_vpc_network.mysql_network.id
  subnet_id    = yandex_vpc_subnet.mysql_subnet.id
  zone         = var.zone
  ha           = true  
  
  # Минимальная конфигурация для экономии
  resource_preset_id = "b2.medium"  # 2 vCPU, 4 GB RAM
  disk_type_id       = "network-hdd"
  disk_size          = 10
  
  # Отключаем ненужные опции для экономии
  access_data_lens     = false
  access_web_sql       = false
  access_data_transfer = false
  performance_diagnostics_enabled = false
}

# Добавляем базу данных и пользователя
module "mysql_db" {
  source = "./modules/mysql_db_user"
  
  cluster_id    = module.mysql_cluster.cluster_id
  database_name = "testdb"
  username      = "appuser"
  password      = random_password.mysql_password.result
  roles         = ["ALL"]
}

# Outputs
output "mysql_network_info" {
  description = "MySQL VPC network information"
  value = {
    network_id   = yandex_vpc_network.mysql_network.id
    network_name = yandex_vpc_network.mysql_network.name
    subnet_id    = yandex_vpc_subnet.mysql_subnet.id
    subnet_cidr  = yandex_vpc_subnet.mysql_subnet.v4_cidr_blocks[0]
  }
}

output "mysql_cluster_info" {
  description = "MySQL cluster information"
  value       = module.mysql_cluster.cluster_info
}

output "mysql_connection" {
  description = "MySQL connection information"
  value = {
    cluster_id   = module.mysql_cluster.cluster_id
    database     = module.mysql_db.database_name
    username     = module.mysql_db.username
    password     = random_password.mysql_password.result
  }
  sensitive = true
}

output "mysql_hosts" {
  description = "MySQL cluster hosts"
  value       = module.mysql_cluster.hosts
}
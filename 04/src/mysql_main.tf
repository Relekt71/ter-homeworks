# ============================================
# Генерация случайного пароля для MySQL
# ============================================
resource "random_password" "mysql_password" {
  length  = 16
  special = false
  numeric = true
  upper   = true
  lower   = true
}

# ============================================
# Создаем VPC сеть для MySQL (вместо использования существующей)
# ============================================
resource "yandex_vpc_network" "mysql_network" {
  name        = "mysql-network"
  description = "Network for MySQL cluster"
  
  labels = {
    environment = "dev"
    managed_by  = "terraform"
    purpose     = "mysql-cluster"
  }
}

# ============================================
# Создаем подсеть для MySQL
# ============================================
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

# ============================================
# Модуль MySQL кластера
# ============================================
module "mysql_cluster" {
  source = "./modules/mysql_cluster"
  
  cluster_name     = var.mysql_cluster_name
  environment      = "PRESTABLE"
  network_id       = yandex_vpc_network.mysql_network.id
  subnet_id        = yandex_vpc_subnet.mysql_subnet.id
  zone             = var.zone
  ha               = var.mysql_ha
  resource_preset_id = var.mysql_resource_preset
  disk_size        = var.mysql_disk_size
  mysql_version    = var.mysql_version
}

# ============================================
# Модуль базы данных и пользователя
# ============================================
module "mysql_db_user" {
  source = "./modules/mysql_db_user"
  
  cluster_id    = module.mysql_cluster.cluster_id
  database_name = var.mysql_database_name
  username      = var.mysql_username
  password      = random_password.mysql_password.result
  roles         = ["ALL"]
}
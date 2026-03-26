terraform {
  required_version = ">= 1.12.0"
  
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.87"
    }
  }
}

provider "yandex" {
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
  service_account_key_file = var.service_account_key_file
}

# ============================================
# Задание 2 и 4*: VPC модуль
# ============================================

module "vpc_dev" {
  source   = "./modules/vpc"
  env_name = var.vpc_dev_name
  subnets  = var.vpc_dev_subnets
  labels   = var.common_labels
}

module "vpc_prod" {
  source   = "./modules/vpc"
  env_name = var.vpc_prod_name
  subnets  = var.vpc_prod_subnets
  labels   = var.common_labels
}

# ============================================
# Security groups
# ============================================

module "mysql_sg" {
  source = "./modules/security_group"
  
  name        = "${var.vpc_dev_name}-mysql-sg"
  description = "Security group for MySQL cluster"
  network_id  = module.vpc_dev.network_id
  labels      = var.common_labels
  
  ingress_rules = [
    {
      protocol       = "TCP"
      description    = "MySQL port"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 3306
    },
    {
      protocol       = "TCP"
      description    = "SSH for management"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 22
    }
  ]
  
  egress_rules = [
    {
      protocol       = "ANY"
      description    = "Allow all outbound"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = -1
    }
  ]
}

module "vm_sg" {
  source = "./modules/security_group"
  
  name        = "${var.vpc_dev_name}-vm-sg"
  description = "Security group for VMs"
  network_id  = module.vpc_dev.network_id
  labels      = var.common_labels
  
  ingress_rules = [
    {
      protocol       = "TCP"
      description    = "SSH"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 22
    },
    {
      protocol       = "TCP"
      description    = "HTTP"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 80
    },
    {
      protocol       = "TCP"
      description    = "HTTPS"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 443
    }
  ]
  
  egress_rules = [
    {
      protocol       = "ANY"
      description    = "Allow all outbound"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = -1
    }
  ]
}

# ============================================
# Задание 1: ВМ с nginx
# ============================================

module "marketing_vm" {
  source = "./modules/vm"
  
  name        = var.marketing_vm_name
  project     = "marketing"
  username    = var.vm_username
  ssh_key     = file(var.ssh_public_key_path)
  zone        = var.zone
  subnet_id   = module.vpc_dev.subnets[var.zone].id
  image_id    = var.vm_image_id
  platform_id = var.vm_platform_id
  cores       = var.vm_cores
  memory      = var.vm_memory
  disk_size   = var.vm_disk_size
  nat_enabled = true
  core_fraction = var.vm_core_fraction
  security_group_ids = [module.vm_sg.id]
  
  labels = merge(var.common_labels, {
    project = "marketing"
    task    = "task1"
    env     = "develop"
  })
}

module "analytics_vm" {
  source = "./modules/vm"
  
  name        = var.analytics_vm_name
  project     = "analytics"
  username    = var.vm_username
  ssh_key     = file(var.ssh_public_key_path)
  zone        = var.zone
  subnet_id   = module.vpc_prod.subnets[var.zone].id
  image_id    = var.vm_image_id
  platform_id = var.vm_platform_id
  cores       = var.vm_cores
  memory      = var.vm_memory
  disk_size   = var.vm_disk_size
  nat_enabled = true
  core_fraction = var.vm_core_fraction
  security_group_ids = [module.vm_sg.id]
  
  labels = merge(var.common_labels, {
    project = "analytics"
    task    = "task1"
    env     = "production"
  })
}

# ============================================
# Задание 5*: MySQL кластер
# ============================================

module "mysql_cluster" {
  source = "./modules/mysql_cluster"
  
  cluster_name          = var.mysql_cluster_name
  environment           = var.mysql_environment
  network_id            = module.vpc_dev.network_id
  subnet_ids = [
    for zone_name, subnet in module.vpc_dev.subnets :
    {
      id   = subnet.id
      zone = subnet.zone
    }
  ]
  ha_enabled            = var.mysql_ha_enabled
  mysql_version         = var.mysql_version
  resource_preset_id    = var.mysql_resource_preset_id
  disk_type_id          = var.mysql_disk_type_id
  disk_size             = var.mysql_disk_size
  backup_window_hours   = var.mysql_backup_window_hours
  backup_window_minutes = var.mysql_backup_window_minutes
  backup_retain_period  = var.mysql_backup_retain_period
  security_group_ids    = [module.mysql_sg.id]
  
  labels = merge(var.common_labels, {
    task = "task5"
    type = "mysql"
  })
}

module "mysql_db_user" {
  source = "./modules/mysql_db_user"
  
  cluster_id     = module.mysql_cluster.cluster_id
  database_name  = var.mysql_database_name
  user_name      = var.mysql_user_name
  user_password  = var.mysql_user_password
  user_roles     = var.mysql_user_roles
  
  depends_on = [module.mysql_cluster]
}
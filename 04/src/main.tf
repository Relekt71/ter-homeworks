# ============================================
# Модуль VPC (Задания 1-3)
# ============================================
module "vpc_dev" {
  source   = "./modules/vpc"
  env_name = var.vpc_name
  zone     = var.zone
  cidr     = var.vpc_cidr
}

# ============================================
# Модуль Marketing VM (Задание 1)
# ============================================
module "marketing_vm" {
  source = "./modules/vm"
  
  name        = "marketing-vm"
  project     = "marketing"
  username    = var.vm_username
  ssh_key     = local.ssh_public_key
  zone        = var.zone
  subnet_id   = module.vpc_dev.subnet_id
  image_id    = var.image_id
  platform_id = var.platform_id
  cores       = 2
  memory      = 2
  disk_size   = 10
  
  labels = {
    project    = "marketing"
    env        = var.vpc_name
    owner      = "devops"
    managed_by = "terraform"
  }
}

# ============================================
# Модуль Analytics VM (Задание 1)
# ============================================
module "analytics_vm" {
  source = "./modules/vm"
  
  name        = "analytics-vm"
  project     = "analytics"
  username    = var.vm_username
  ssh_key     = local.ssh_public_key
  zone        = var.zone
  subnet_id   = module.vpc_dev.subnet_id
  image_id    = var.image_id
  platform_id = var.platform_id
  cores       = 2
  memory      = 2
  disk_size   = 10
  
  labels = {
    project    = "analytics"
    env        = var.vpc_name
    owner      = "devops"
    managed_by = "terraform"
  }
}
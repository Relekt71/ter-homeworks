# main.tf
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.2"
    }
  }
  required_version = ">= 1.0"
}

provider "yandex" {
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  service_account_key_file = file(var.token_path)
  zone                     = var.default_zone
}

locals {
  ssh_public_key = file(var.vms_ssh_root_key_path)
}

# Создание VPC сети
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

# Создание подсети в зоне a
resource "yandex_vpc_subnet" "develop_a" {
  name           = "${var.vpc_name}-ru-central1-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}

# Создание подсети в зоне b
resource "yandex_vpc_subnet" "develop_b" {
  name           = "${var.vpc_name}-ru-central1-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.2.0/24"]
}

# Cloud-init для marketing ВМ
data "template_file" "cloudinit_marketing" {
  template = file("${path.module}/cloud-init.yml")
  
  vars = {
    ssh_public_key = local.ssh_public_key
    vm_name        = "marketing-vm"
    vm_project     = "marketing"
  }
}

# Cloud-init для analytics ВМ
data "template_file" "cloudinit_analytics" {
  template = file("${path.module}/cloud-init.yml")
  
  vars = {
    ssh_public_key = local.ssh_public_key
    vm_name        = "analytics-vm"
    vm_project     = "analytics"
  }
}

# ВМ для marketing проекта
module "marketing_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "marketing"
  network_id     = yandex_vpc_network.develop.id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [yandex_vpc_subnet.develop_a.id]
  instance_name  = "marketing-vm"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = { 
    owner   = "i.ivanov"
    project = "marketing"
    env     = "prod"
    purpose = "web"
  }

  metadata = {
    user-data          = data.template_file.cloudinit_marketing.rendered
    serial-port-enable = 1
  }
}

# ВМ для analytics проекта
module "analytics_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "analytics"
  network_id     = yandex_vpc_network.develop.id
  subnet_zones   = ["ru-central1-b"]
  subnet_ids     = [yandex_vpc_subnet.develop_b.id]
  instance_name  = "analytics-vm"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = { 
    owner   = "i.ivanov"
    project = "analytics"
    env     = "prod"
    purpose = "data-processing"
  }

  metadata = {
    user-data          = data.template_file.cloudinit_analytics.rendered
    serial-port-enable = 1
  }
}

# Вывод информации используя правильные атрибуты модуля
output "marketing_vm_ip" {
  description = "External IP address of marketing VM"
  value       = module.marketing_vm.external_ip_address[0]
}

output "analytics_vm_ip" {
  description = "External IP address of analytics VM"
  value       = module.analytics_vm.external_ip_address[0]
}

output "marketing_vm_internal_ip" {
  description = "Internal IP address of marketing VM"
  value       = module.marketing_vm.internal_ip_address[0]
}

output "analytics_vm_internal_ip" {
  description = "Internal IP address of analytics VM"
  value       = module.analytics_vm.internal_ip_address[0]
}

output "marketing_vm_fqdn" {
  description = "FQDN of marketing VM"
  value       = module.marketing_vm.fqdn[0]
}

output "analytics_vm_fqdn" {
  description = "FQDN of analytics VM"
  value       = module.analytics_vm.fqdn[0]
}

output "vms_info" {
  description = "Complete information about all VMs"
  value = {
    marketing = {
      name        = "marketing-vm"
      fqdn        = module.marketing_vm.fqdn[0]
      external_ip = module.marketing_vm.external_ip_address[0]
      internal_ip = module.marketing_vm.internal_ip_address[0]
      labels      = module.marketing_vm.labels
    }
    analytics = {
      name        = "analytics-vm"
      fqdn        = module.analytics_vm.fqdn[0]
      external_ip = module.analytics_vm.external_ip_address[0]
      internal_ip = module.analytics_vm.internal_ip_address[0]
      labels      = module.analytics_vm.labels
    }
  }
}

# Remote state outputs
output "out" {
  description = "Output for remote state"
  value = {
    marketing = {
      name        = "marketing-vm"
      fqdn        = module.marketing_vm.fqdn[0]
      external_ip = module.marketing_vm.external_ip_address[0]
      internal_ip = module.marketing_vm.internal_ip_address[0]
      labels      = module.marketing_vm.labels
    }
    analytics = {
      name        = "analytics-vm"
      fqdn        = module.analytics_vm.fqdn[0]
      external_ip = module.analytics_vm.external_ip_address[0]
      internal_ip = module.analytics_vm.internal_ip_address[0]
      labels      = module.analytics_vm.labels
    }
  }
}

# Дополнительный вывод для совместимости с вашим существующим кодом
output "vms_list" {
  description = "List of VM FQDNs"
  value = [
    module.marketing_vm.fqdn[0],
    module.analytics_vm.fqdn[0]
  ]
}
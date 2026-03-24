terraform {
  required_version = ">= 1.0"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.87"
    }
  }
}

# Создание VPC сети (опционально)
resource "yandex_vpc_network" "this" {
  count = var.create_network ? 1 : 0
  
  name        = "${var.env_name}-network"
  description = "Network for ${var.env_name} environment"
  
  labels = {
    environment = var.env_name
    managed_by  = "terraform"
    created     = "module-vpc"
  }
}

# Использование существующей сети или созданной
locals {
  network_id = var.create_network ? yandex_vpc_network.this[0].id : var.existing_network_id
}

# Создание подсетей
resource "yandex_vpc_subnet" "this" {
  count = length(var.subnets)
  
  name           = "${var.env_name}-subnet-${var.subnets[count.index].zone}"
  description    = "Subnet for ${var.env_name} environment in ${var.subnets[count.index].zone}"
  zone           = var.subnets[count.index].zone
  network_id     = local.network_id
  v4_cidr_blocks = [var.subnets[count.index].cidr]
  
  labels = {
    environment = var.env_name
    zone        = var.subnets[count.index].zone
    cidr        = replace(var.subnets[count.index].cidr, "/", "-")
    managed_by  = "terraform"
    created     = "module-vpc"
  }
}
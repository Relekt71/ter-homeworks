terraform {
  required_version = ">= 1.3.0"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.92"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

resource "yandex_vpc_network" "this" {
  name        = "${var.env_name}-network"
  description = "Network for ${var.env_name} environment"
  
  labels = {
    environment = var.env_name
    managed_by  = "terraform"
  }
}

resource "yandex_vpc_subnet" "this" {
  name           = "${var.env_name}-subnet-${var.zone}"
  description    = "Subnet for ${var.env_name} in ${var.zone}"
  zone           = var.zone
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = [var.cidr]
  
  labels = {
    environment = var.env_name
    zone        = var.zone
    managed_by  = "terraform"
  }
}
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
  labels      = var.labels
}

resource "yandex_vpc_subnet" "this" {
  count = length(var.subnets)
  
  name           = "${var.env_name}-subnet-${var.subnets[count.index].zone}"
  description    = "Subnet for ${var.env_name} in ${var.subnets[count.index].zone}"
  zone           = var.subnets[count.index].zone
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = [var.subnets[count.index].cidr]
  
  labels = merge(var.labels, {
    zone = var.subnets[count.index].zone
  })
}
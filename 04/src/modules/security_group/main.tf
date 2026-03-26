terraform {
  required_version = ">= 1.12.0"
  
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.87"
    }
  }
}

resource "yandex_vpc_security_group" "this" {
  name        = var.name
  description = var.description
  network_id  = var.network_id
  labels      = var.labels

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      protocol       = ingress.value.protocol
      description    = ingress.value.description
      v4_cidr_blocks = ingress.value.v4_cidr_blocks
      port           = ingress.value.port
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      protocol       = egress.value.protocol
      description    = egress.value.description
      v4_cidr_blocks = egress.value.v4_cidr_blocks
      port           = egress.value.port
    }
  }
}
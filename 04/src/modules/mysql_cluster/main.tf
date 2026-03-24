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

resource "yandex_mdb_mysql_cluster" "this" {
  name        = var.cluster_name
  description = "MySQL cluster for ${var.environment}"
  environment = var.environment
  network_id  = var.network_id
  version     = var.mysql_version

  resources {
    resource_preset_id = var.resource_preset_id
    disk_type_id       = var.disk_type_id
    disk_size          = var.disk_size
  }

  dynamic "host" {
    for_each = var.ha ? [1, 2] : [1]
    content {
      zone      = var.zone
      subnet_id = var.subnet_id
    }
  }

  access {
    data_lens     = false
    web_sql       = false
    data_transfer = false
  }

  backup_window_start {
    hours   = 1
    minutes = 0
  }
}
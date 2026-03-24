terraform {
  required_version = ">= 1.0"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.87"
    }
  }
}

# Создание кластера Managed MySQL
resource "yandex_mdb_mysql_cluster" "this" {
  name        = var.cluster_name
  description = "MySQL cluster for ${var.environment}"
  environment = var.environment
  network_id  = var.network_id
  version     = var.mysql_version
  
  labels = {
    environment = lower(var.environment)  # PRESTABLE -> prestable
    managed_by  = "terraform"
    ha_mode     = var.ha ? "enabled" : "disabled"
  }

  resources {
    resource_preset_id = var.resource_preset_id
    disk_type_id       = var.disk_type_id
    disk_size          = var.disk_size
  }

  # Динамическое создание хостов в зависимости от HA
  dynamic "host" {
    for_each = var.ha ? [1, 2] : [1]
    content {
      zone      = var.zone
      subnet_id = var.subnet_id
    }
  }

  # Настройки безопасности
  security_group_ids = var.security_group_ids

  # Настройки резервного копирования
  backup_window_start {
    hours   = var.backup_hour_start
    minutes = var.backup_minute_start
  }

  # Настройки доступа
  access {
    data_lens     = var.access_data_lens
    web_sql       = var.access_web_sql
    data_transfer = var.access_data_transfer
  }

  # Настройки производительности
  performance_diagnostics {
    enabled                      = var.performance_diagnostics_enabled
    sessions_sampling_interval   = var.sessions_sampling_interval
    statements_sampling_interval = var.statements_sampling_interval
  }
}
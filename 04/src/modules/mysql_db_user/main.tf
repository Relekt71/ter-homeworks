terraform {
  required_version = ">= 1.0"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.87"
    }
  }
}

# Создание базы данных
resource "yandex_mdb_mysql_database" "this" {
  cluster_id = var.cluster_id
  name       = var.database_name
}

# Создание пользователя
resource "yandex_mdb_mysql_user" "this" {
  cluster_id = var.cluster_id
  name       = var.username
  password   = var.password
  
  permission {
    database_name = yandex_mdb_mysql_database.this.name
    roles         = var.roles
  }
  
  # Настройки глобальных привилегий (опционально)
  global_permissions = var.global_permissions
}
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

# Генерируем уникальное имя бакета
resource "random_string" "unique_id" {
  length  = 8
  special = false
  upper   = false
}

locals {
  bucket_name = "bucket-${random_string.unique_id.result}"
}

# Создаем S3 бакет (без версионирования и шифрования)
resource "yandex_storage_bucket" "this" {
  bucket = local.bucket_name
  acl    = "private"
  
  force_destroy = false
}

output "bucket_name" {
  value = yandex_storage_bucket.this.bucket
}

output "bucket_url" {
  value = "https://storage.yandexcloud.net/${yandex_storage_bucket.this.bucket}"
}
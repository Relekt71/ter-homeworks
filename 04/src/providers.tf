terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
    template = {
      source = "hashicorp/template"
      version = "~> 2.2"
    }
  }
  required_version = ">=1.12.0"
}

provider "yandex" {
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  service_account_key_file = local.ssh_key
  zone                     = "ru-central1-a"
}
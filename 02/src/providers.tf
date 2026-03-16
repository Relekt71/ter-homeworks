terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.192.0" 
    }
  }
  required_version = "~>1.14.0"
}

provider "yandex" {
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.default_zone
  service_account_key_file = "/home/relekt/Terra/ter-homeworks/02/src/key.json"
}
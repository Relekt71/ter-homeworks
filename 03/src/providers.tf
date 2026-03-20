terraform {

    required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.193.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.7.0"
    }
        
  }
  required_version = ">=1.12.0"
}
#locals {

#  yc_token = file(var.token)
#}
provider "yandex" {
  service_account_key_file = local.yc_token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}
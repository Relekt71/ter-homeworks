terraform {
  required_version = ">= 1.12.0"
  
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.87"
    }
  }
}

resource "yandex_compute_instance" "vm" {
  name        = var.name
  description = "VM for ${var.project} project"
  platform_id = var.platform_id
  zone        = var.zone
  
  labels = var.labels

  resources {
    cores         = var.cores
    memory        = var.memory
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = var.disk_size
    }
  }

  network_interface {
    subnet_id          = var.subnet_id
    nat                = var.nat_enabled # Public IP required for external nginx access (CKV_YC_2 ignored intentionally)
    security_group_ids = var.security_group_ids
  }

  metadata = {
    user-data = templatefile("${path.module}/cloud-init.yml.tpl", {
      ssh_public_key = var.ssh_key
      username       = var.username
      nginx_port     = var.nginx_port
    })
  }
  
  lifecycle {
    create_before_destroy = true
  }
}

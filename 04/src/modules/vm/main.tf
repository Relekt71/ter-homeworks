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

resource "yandex_compute_instance" "vm" {
  name        = var.name
  description = "VM for ${var.project} project"
  platform_id = var.platform_id
  zone        = var.zone
  
  labels = var.labels

  resources {
    cores  = var.cores
    memory = var.memory
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = var.disk_size
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = var.nat_enabled
  }

  metadata = {
    user-data = templatefile("${path.module}/cloud-init.yml.tpl", {
      ssh_public_key = var.ssh_key
      username       = var.username
      nginx_port     = var.nginx_port
    })
  }
}
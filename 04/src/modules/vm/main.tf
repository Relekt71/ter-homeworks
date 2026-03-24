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
    nat       = true
  }

  metadata = {
    user-data = templatefile("${path.module}/templates/cloud-init.yml.tpl", {
      username       = var.username
      ssh_public_key = var.ssh_key
    })
  }
}
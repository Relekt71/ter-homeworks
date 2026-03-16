resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_vpc_subnet" "develop-db" {
  name           = "${var.vpc_name}-db"
    zone         = var.vms_resources["db"].zone    
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.2.0/24"]    
}

data "yandex_compute_image" "ubuntu" {
  family = var.vms_resources["web"].image_family
}
resource "yandex_compute_instance" "platform" {
  name        = local.web_vm_name
  platform_id = var.vms_resources["web"].platform_id
  zone        = var.vms_resources["web"].zone

  resources {
    cores         = var.vms_resources["web"].cores
    memory        = var.vms_resources["web"].memory
    core_fraction = var.vms_resources["web"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vms_resources["web"].hdd_size
      type     = var.vms_resources["web"].hdd_type
    }
  }
  scheduling_policy {
      preemptible = var.vms_resources["web"].preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vms_resources["web"].nat
  }

  metadata = local.metadata

}

# ВМ для базы данных 

resource "yandex_compute_instance" "platform-db" {
  name        = local.db_vm_name
  platform_id = var.vms_resources["db"].platform_id
  zone        = var.vms_resources["db"].zone
  
  resources {
    cores         = var.vms_resources["db"].cores
    memory        = var.vms_resources["db"].memory
    core_fraction = var.vms_resources["db"].core_fraction
  }
  
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vms_resources["db"].hdd_size
      type     = var.vms_resources["db"].hdd_type
    }
  }
  
  scheduling_policy {
    preemptible = var.vms_resources["db"].preemptible
  }
  
  network_interface {
    subnet_id = yandex_vpc_subnet.develop-db.id
    nat       = var.vms_resources["db"].nat
  }

  metadata = local.metadata

  depends_on = [
    yandex_vpc_subnet.develop-db
  ]
}
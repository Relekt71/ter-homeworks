# Создаем дополнительные диски
resource "yandex_compute_disk" "storage_disks" {
  count = var.storage_disks.count
  
  name       = "storage-disk-${count.index + 1}"
  type       = var.storage_disks.type
  zone       = var.default_zone
  size       = var.storage_disks.size

  description = "Additional disk for storage VM ${count.index + 1}"
}

# Создаем storage ВМ
resource "yandex_compute_instance" "storage" {
  name        = var.storage_instance.name
  platform_id = var.storage_instance.platform_id
  zone        = var.default_zone

  resources {
    cores         = var.storage_instance.cpu
    memory        = var.storage_instance.ram
    core_fraction = var.storage_instance.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.os.id
      size     = var.storage_instance.boot_disk_size
    }
  }
  
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage_disks
    content {
      disk_id = secondary_disk.value.id
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh_key}"
  }

  scheduling_policy {
    preemptible = var.storage_instance.preemptible
  }

  depends_on = [yandex_compute_disk.storage_disks]
}
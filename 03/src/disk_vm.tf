resource "yandex_compute_disk" "storage_disks" {
  count = 3
  
  name       = "storage-disk-${count.index + 1}"
  type       = "network-hdd"
  zone       = var.default_zone
  size       = 5
  image_id   = "fd80rt9kfkrpsq4dh9c9" # Ubuntu 20.04 LTS

  description = "Additional disk for storage VM ${count.index + 1}"
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = "standard-v3"
  zone        = var.default_zone

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd80rt9kfkrpsq4dh9c9" # Ubuntu 20.04 LTS
      size     = 10
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
    preemptible = true
  }

  depends_on = [yandex_compute_disk.storage_disks]
}
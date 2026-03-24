resource "yandex_compute_instance" "web" {
  count = var.web_instances.count
  
  name        = "web-${count.index + 1}"
  platform_id = var.web_instances.platform_id
  zone        = var.default_zone

  resources {
    cores         = var.web_instances.cpu
    memory        = var.web_instances.ram
    core_fraction = var.web_instances.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.os.id
      size     = var.web_instances.disk_size
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
    preemptible = var.web_instances.preemptible
  }

  depends_on = [yandex_compute_instance.db]
}
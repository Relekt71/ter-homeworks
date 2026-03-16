output "all_vms_info" {
  description = "Информация о всех созданных ВМ"
  value = {
    web_vm = {
      instance_name = yandex_compute_instance.platform.name
      external_ip   = yandex_compute_instance.platform.network_interface.0.nat_ip_address
      fqdn          = yandex_compute_instance.platform.fqdn
    }
    db_vm = {
      instance_name = yandex_compute_instance.platform-db.name
      external_ip   = yandex_compute_instance.platform-db.network_interface.0.nat_ip_address
      fqdn          = yandex_compute_instance.platform-db.fqdn
    }
  }
}
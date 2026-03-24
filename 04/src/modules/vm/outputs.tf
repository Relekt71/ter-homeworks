output "external_ip" {
  value = yandex_compute_instance.vm.network_interface.0.nat_ip_address
}

output "internal_ip" {
  value = yandex_compute_instance.vm.network_interface.0.ip_address
}

output "vm_name" {
  value = yandex_compute_instance.vm.name
}

output "vm_id" {
  value = yandex_compute_instance.vm.id
}

output "labels" {
  value = yandex_compute_instance.vm.labels
}
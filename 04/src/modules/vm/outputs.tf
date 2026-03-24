output "external_ip" {
  description = "External IP address"
  value       = yandex_compute_instance.vm.network_interface.0.nat_ip_address
}

output "internal_ip" {
  description = "Internal IP address"
  value       = yandex_compute_instance.vm.network_interface.0.ip_address
}

output "vm_id" {
  description = "VM ID"
  value       = yandex_compute_instance.vm.id
}

output "vm_name" {
  description = "VM name"
  value       = yandex_compute_instance.vm.name
}
# ansible.tf

# Создание inventory файла с помощью local провайдера
resource "local_file" "ansible_inventory" {
  filename = "${abspath(path.module)}/inventory.ini"
  content = templatefile("${path.module}/inventory.tftpl", {
    webservers = yandex_compute_instance.web
    databases  = yandex_compute_instance.db
    storage_vm = yandex_compute_instance.storage
  })
  depends_on = [
    yandex_compute_instance.web,
    yandex_compute_instance.db,
    yandex_compute_instance.storage
  ]
}

# Output для просмотра содержимого файла
output "inventory_content" {
  value = local_file.ansible_inventory.content
  description = "Content of generated Ansible inventory file"
  sensitive = false
}

# Output для просмотра пути к файлу
output "inventory_file_path" {
  value = local_file.ansible_inventory.filename
  description = "Path to generated Ansible inventory file"
}

# Вывод FQDN всех ВМ
output "fqdns" {
  value = {
    webservers = [for instance in yandex_compute_instance.web : instance.fqdn]
    databases  = [for name, instance in yandex_compute_instance.db : instance.fqdn]
    storage    = yandex_compute_instance.storage.fqdn
  }
  description = "FQDNs of all instances"
}

# Вывод внешних IP
output "external_ips" {
  value = {
    webservers = [for instance in yandex_compute_instance.web : instance.network_interface.0.nat_ip_address]
    databases  = [for name, instance in yandex_compute_instance.db : instance.network_interface.0.nat_ip_address]
    storage    = yandex_compute_instance.storage.network_interface.0.nat_ip_address
  }
  description = "External IP addresses"
}

# Вывод внутренних IP
output "internal_ips" {
  value = {
    webservers = [for instance in yandex_compute_instance.web : instance.network_interface.0.ip_address]
    databases  = [for name, instance in yandex_compute_instance.db : instance.network_interface.0.ip_address]
    storage    = yandex_compute_instance.storage.network_interface.0.ip_address
  }
  description = "Internal IP addresses"
}

# Вывод полной информации о веб-серверах
output "webservers_info" {
  value = {
    for instance in yandex_compute_instance.web :
    instance.name => {
      external_ip = instance.network_interface.0.nat_ip_address
      internal_ip = instance.network_interface.0.ip_address
      fqdn = instance.fqdn
      cpu = instance.resources.0.cores
      ram = instance.resources.0.memory
    }
  }
  description = "Web servers detailed information"
}

# Вывод полной информации о базах данных
output "databases_info" {
  value = {
    for name, instance in yandex_compute_instance.db :
    name => {
      external_ip = instance.network_interface.0.nat_ip_address
      internal_ip = instance.network_interface.0.ip_address
      fqdn = instance.fqdn
      cpu = instance.resources.0.cores
      ram = instance.resources.0.memory
      disk_size = instance.boot_disk.0.initialize_params.0.size
    }
  }
  description = "Database instances detailed information"
}

# Вывод полной информации о storage
output "storage_info" {
  value = {
    name = yandex_compute_instance.storage.name
    external_ip = yandex_compute_instance.storage.network_interface.0.nat_ip_address
    internal_ip = yandex_compute_instance.storage.network_interface.0.ip_address
    fqdn = yandex_compute_instance.storage.fqdn
    cpu = yandex_compute_instance.storage.resources.0.cores
    ram = yandex_compute_instance.storage.resources.0.memory
    attached_disks = [for disk in yandex_compute_disk.storage_disks : disk.name]
  }
  description = "Storage instance detailed information"
}
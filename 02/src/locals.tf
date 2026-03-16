locals {
  ssh_key_content = file(var.vms_ssh_root_key_path)
  web_vm_name = "netology-develop-platform-web-${var.vms_resources["web"].zone}"
  db_vm_name  = "netology-develop-platform-db-${var.vms_resources["db"].zone}"

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

}


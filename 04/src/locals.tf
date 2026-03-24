# locals.tf

locals {
  # Чтение SSH ключа из файла
  ssh_public_key = file(var.ssh_key_path)
}
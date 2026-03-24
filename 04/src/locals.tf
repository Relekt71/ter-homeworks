locals {
  ssh_public_key = file(var.ssh_key_path)
}
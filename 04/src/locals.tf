locals {
  yc_token = file(var.token_path)
  ssh_key  = file(var.vms_ssh_root_key_path)
}
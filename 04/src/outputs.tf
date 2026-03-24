# ============================================
# Outputs для VPC и VM (Задания 1-3)
# ============================================
output "vpc_info" {
  description = "VPC information"
  value = {
    network_id   = module.vpc_dev.network_id
    network_name = module.vpc_dev.network_name
    subnet_id    = module.vpc_dev.subnet_id
    subnet_cidr  = module.vpc_dev.subnet_cidr
    zone         = module.vpc_dev.zone
  }
}

output "marketing_vm" {
  description = "Marketing VM information"
  value = {
    name        = module.marketing_vm.vm_name
    external_ip = module.marketing_vm.external_ip
    internal_ip = module.marketing_vm.internal_ip
    labels      = module.marketing_vm.labels
  }
}

output "analytics_vm" {
  description = "Analytics VM information"
  value = {
    name        = module.analytics_vm.vm_name
    external_ip = module.analytics_vm.external_ip
    internal_ip = module.analytics_vm.internal_ip
    labels      = module.analytics_vm.labels
  }
}
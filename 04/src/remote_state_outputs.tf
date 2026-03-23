output "out" {
  value = {
    marketing = {
      name       = module.marketing_vm.instance_name
      fqdn       = module.marketing_vm.fqdn[0]
      external_ip = module.marketing_vm.external_ip[0]
      internal_ip = module.marketing_vm.internal_ip[0]
      labels      = module.marketing_vm.labels
    }
    analytics = {
      name       = module.analytics_vm.instance_name
      fqdn       = module.analytics_vm.fqdn[0]
      external_ip = module.analytics_vm.external_ip[0]
      internal_ip = module.analytics_vm.internal_ip[0]
      labels      = module.analytics_vm.labels
    }
  }
  description = "Information about created VMs for remote state"
}

output "vms_list" {
  value = concat(module.marketing_vm.fqdn, module.analytics_vm.fqdn)
}
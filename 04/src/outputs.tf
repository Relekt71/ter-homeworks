# ============================================
# Задание 1: Outputs для ВМ
# ============================================

output "marketing_vm_external_ip" {
  description = "External IP of marketing VM"
  value       = module.marketing_vm.external_ip
}

output "analytics_vm_external_ip" {
  description = "External IP of analytics VM"
  value       = module.analytics_vm.external_ip
}

output "marketing_vm_internal_ip" {
  description = "Internal IP of marketing VM"
  value       = module.marketing_vm.internal_ip
}

output "analytics_vm_internal_ip" {
  description = "Internal IP of analytics VM"
  value       = module.analytics_vm.internal_ip
}

# ============================================
# Задание 2: Outputs для VPC Dev
# ============================================

output "vpc_dev_info" {
  description = "Information about development VPC"
  value = {
    network_id   = module.vpc_dev.network_id
    network_name = module.vpc_dev.network_name
    subnets      = module.vpc_dev.subnets
  }
}

# ============================================
# Задание 4*: Outputs для VPC Prod
# ============================================

output "vpc_prod_info" {
  description = "Information about production VPC with subnets in all zones"
  value = {
    network_id   = module.vpc_prod.network_id
    network_name = module.vpc_prod.network_name
    subnets      = module.vpc_prod.subnets
  }
}

# ============================================
# Задание 5*: Outputs для MySQL
# ============================================

output "mysql_cluster_info" {
  description = "Information about MySQL cluster"
  value = {
    cluster_id   = module.mysql_cluster.cluster_id
    cluster_name = module.mysql_cluster.cluster_name
    hosts        = module.mysql_cluster.hosts
    ha_enabled   = module.mysql_cluster.ha_enabled
  }
}

output "mysql_database_info" {
  description = "Information about created database and user"
  value = {
    database_name = module.mysql_db_user.database_name
    user_name     = module.mysql_db_user.user_name
  }
  sensitive = true
}
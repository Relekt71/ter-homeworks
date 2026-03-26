# ============================================
# Задание 1: Outputs для ВМ
# ============================================

output "marketing_vm_external_ip" {
  description = "External IP of marketing VM (Task 1)"
  value       = module.marketing_vm.external_ip
}

output "analytics_vm_external_ip" {
  description = "External IP of analytics VM (Task 1)"
  value       = module.analytics_vm.external_ip
}

output "marketing_vm_internal_ip" {
  description = "Internal IP of marketing VM (Task 1)"
  value       = module.marketing_vm.internal_ip
}

output "analytics_vm_internal_ip" {
  description = "Internal IP of analytics VM (Task 1)"
  value       = module.analytics_vm.internal_ip
}

output "marketing_vm_name" {
  description = "Name of marketing VM"
  value       = module.marketing_vm.vm_name
}

output "analytics_vm_name" {
  description = "Name of analytics VM"
  value       = module.analytics_vm.vm_name
}

# ============================================
# Задание 2: Outputs для VPC Dev
# ============================================

output "vpc_dev_network_id" {
  description = "ID of development VPC network (Task 2)"
  value       = module.vpc_dev.network_id
}

output "vpc_dev_network_name" {
  description = "Name of development VPC network (Task 2)"
  value       = module.vpc_dev.network_name
}

output "vpc_dev_subnets" {
  description = "Subnets of development VPC (Task 2)"
  value       = module.vpc_dev.subnets
}

output "vpc_dev_info" {
  description = "Complete information about development VPC (Task 2)"
  value = {
    network_id   = module.vpc_dev.network_id
    network_name = module.vpc_dev.network_name
    subnets      = module.vpc_dev.subnets
  }
}

# ============================================
# Задание 4*: Outputs для VPC Prod
# ============================================

output "vpc_prod_network_id" {
  description = "ID of production VPC network (Task 4*)"
  value       = module.vpc_prod.network_id
}

output "vpc_prod_network_name" {
  description = "Name of production VPC network (Task 4*)"
  value       = module.vpc_prod.network_name
}

output "vpc_prod_subnets" {
  description = "Subnets of production VPC in all zones (Task 4*)"
  value       = module.vpc_prod.subnets
}

output "vpc_prod_info" {
  description = "Complete information about production VPC (Task 4*)"
  value = {
    network_id   = module.vpc_prod.network_id
    network_name = module.vpc_prod.network_name
    subnets      = module.vpc_prod.subnets
  }
}

# ============================================
# Задание 5*: Outputs для MySQL
# ============================================

output "mysql_cluster_id" {
  description = "ID of MySQL cluster (Task 5*)"
  value       = module.mysql_cluster.cluster_id
}

output "mysql_cluster_name" {
  description = "Name of MySQL cluster (Task 5*)"
  value       = module.mysql_cluster.cluster_name
}

output "mysql_cluster_hosts" {
  description = "Hosts of MySQL cluster (Task 5*)"
  value       = module.mysql_cluster.hosts
}

output "mysql_cluster_info" {
  description = "Complete information about MySQL cluster (Task 5*)"
  value = {
    cluster_id   = module.mysql_cluster.cluster_id
    cluster_name = module.mysql_cluster.cluster_name
    hosts        = module.mysql_cluster.hosts
    ha_enabled   = module.mysql_cluster.ha_enabled
  }
}

output "mysql_database_name" {
  description = "Name of created database (Task 5*)"
  value       = module.mysql_db_user.database_name
}

output "mysql_user_name" {
  description = "Name of created user (Task 5*)"
  value       = module.mysql_db_user.user_name
}

output "mysql_database_info" {
  description = "Information about created database and user (Task 5*)"
  value = {
    database_name = module.mysql_db_user.database_name
    user_name     = module.mysql_db_user.user_name
  }
  sensitive = true
}
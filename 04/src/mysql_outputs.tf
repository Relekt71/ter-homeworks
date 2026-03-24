# ============================================
# Outputs для MySQL (Задание 5*)
# ============================================
output "mysql_network_info" {
  description = "MySQL VPC network information"
  value = {
    network_id   = yandex_vpc_network.mysql_network.id
    network_name = yandex_vpc_network.mysql_network.name
    subnet_id    = yandex_vpc_subnet.mysql_subnet.id
    subnet_cidr  = yandex_vpc_subnet.mysql_subnet.v4_cidr_blocks[0]
  }
}

output "mysql_cluster_id" {
  description = "MySQL cluster ID"
  value       = module.mysql_cluster.cluster_id
}

output "mysql_cluster_name" {
  description = "MySQL cluster name"
  value       = module.mysql_cluster.cluster_name
}

output "mysql_cluster_hosts" {
  description = "MySQL cluster hosts"
  value       = module.mysql_cluster.hosts
}

output "mysql_cluster_status" {
  description = "MySQL cluster status"
  value       = module.mysql_cluster.status
}

output "mysql_database_name" {
  description = "MySQL database name"
  value       = module.mysql_db_user.database_name
}

output "mysql_username" {
  description = "MySQL username"
  value       = module.mysql_db_user.username
}

output "mysql_password" {
  description = "MySQL password"
  value       = random_password.mysql_password.result
  sensitive   = true
}

output "mysql_connection_info" {
  description = "MySQL connection information"
  value = {
    network    = yandex_vpc_network.mysql_network.name
    subnet     = yandex_vpc_subnet.mysql_subnet.name
    cluster_id = module.mysql_cluster.cluster_id
    host       = try(module.mysql_cluster.hosts[0].fqdn, "creating...")
    database   = module.mysql_db_user.database_name
    username   = module.mysql_db_user.username
  }
  sensitive = true
}
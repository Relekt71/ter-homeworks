output "cluster_id" {
  description = "ID of the MySQL cluster"
  value       = yandex_mdb_mysql_cluster.this.id
}

output "cluster_name" {
  description = "Name of the MySQL cluster"
  value       = yandex_mdb_mysql_cluster.this.name
}

output "hosts" {
  description = "List of cluster hosts"
  value       = yandex_mdb_mysql_cluster.this.host
}

output "ha_enabled" {
  description = "Whether HA is enabled"
  value       = var.ha_enabled
}
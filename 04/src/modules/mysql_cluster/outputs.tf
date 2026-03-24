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
  value = [
    for host in yandex_mdb_mysql_cluster.this.host : {
      name    = host.name
      fqdn    = host.fqdn
      zone    = host.zone
      subnet  = host.subnet_id
    }
  ]
}

output "cluster_info" {
  description = "Complete cluster information"
  value = {
    id           = yandex_mdb_mysql_cluster.this.id
    name         = yandex_mdb_mysql_cluster.this.name
    environment  = yandex_mdb_mysql_cluster.this.environment
    version      = yandex_mdb_mysql_cluster.this.version
    host_count   = length(yandex_mdb_mysql_cluster.this.host)
    hosts        = [for host in yandex_mdb_mysql_cluster.this.host : host.fqdn]
    resources    = yandex_mdb_mysql_cluster.this.resources
    created_at   = yandex_mdb_mysql_cluster.this.created_at
    health       = yandex_mdb_mysql_cluster.this.health
    status       = yandex_mdb_mysql_cluster.this.status
  }
}
output "cluster_id" {
  value = yandex_mdb_mysql_cluster.this.id
}

output "cluster_name" {
  value = yandex_mdb_mysql_cluster.this.name
}

output "status" {
  value = yandex_mdb_mysql_cluster.this.status
}

output "hosts" {
  value = [
    for host in yandex_mdb_mysql_cluster.this.host : {
      fqdn = host.fqdn
      zone = host.zone
    }
  ]
}
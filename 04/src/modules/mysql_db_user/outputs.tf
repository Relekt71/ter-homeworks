output "database_name" {
  value = yandex_mdb_mysql_database.this.name
}

output "username" {
  value = yandex_mdb_mysql_user.this.name
}
output "database_name" {
  description = "Name of the created database"
  value       = yandex_mdb_mysql_database.this.name
}

output "username" {
  description = "Name of the created user"
  value       = yandex_mdb_mysql_user.this.name
}

output "connection_info" {
  description = "Database connection information"
  value = {
    database = yandex_mdb_mysql_database.this.name
    username = yandex_mdb_mysql_user.this.name
    # password is sensitive and not shown
  }
}
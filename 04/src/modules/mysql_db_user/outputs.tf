output "database_name" {
  description = "Name of the created database"
  value       = yandex_mdb_mysql_database.this.name
}

output "user_name" {
  description = "Name of the created user"
  value       = yandex_mdb_mysql_user.this.name
}

output "database_id" {
  description = "ID of the database"
  value       = yandex_mdb_mysql_database.this.id
}
variable "cluster_id" {
  description = "ID of the MySQL cluster"
  type        = string
}

variable "database_name" {
  description = "Name of the database"
  type        = string
}

variable "username" {
  description = "Username for database access"
  type        = string
}

variable "password" {
  description = "Password for database user"
  type        = string
  sensitive   = true
}

variable "roles" {
  description = "Database roles for the user"
  type        = list(string)
  default     = []  # Доступные роли: ALL, DDL, DML, etc.
}

variable "global_permissions" {
  description = "Global permissions for the user"
  type        = list(string)
  default     = []
}
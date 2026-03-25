variable "cluster_id" {
  description = "ID of the MySQL cluster"
  type        = string
}

variable "database_name" {
  description = "Name of the database"
  type        = string
}

variable "user_name" {
  description = "Name of the database user"
  type        = string
}

variable "user_password" {
  description = "Password for the database user"
  type        = string
  sensitive   = true
}

variable "user_roles" {
  description = "Roles for the database user"
  type        = list(string)
  default     = ["ALL"]
}
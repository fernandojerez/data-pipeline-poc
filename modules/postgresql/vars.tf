variable "database-name" {
  type        = string
  description = "Database name"
}

variable "database-user" {
  type        = string
  description = "database user"
}

variable "database-password" {
  type        = string
  description = "database password"
}

variable "port" {
  type        = number
  description = "database port"
  default     = 5432
}

variable "network-name" {
  type        = string
  description = "network name"
}

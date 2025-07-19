variable "pg_admin" {
  description = "PostgreSQL administrator username"
  type        = string
  default     = "pgadmin"  # Default fallback, meglio usare i secrets
}

variable "pg_pass" { 
  description = "PostgreSQL administrator password"
  type        = string
  sensitive   = true
  # Non mettere default per le password
}

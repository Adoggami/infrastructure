output "server_id" {
  description = "The ID of the PostgreSQL Flexible Server"
  value       = azurerm_postgresql_flexible_server.this.id
}

output "server_name" {
  description = "The name of the PostgreSQL Flexible Server"
  value       = azurerm_postgresql_flexible_server.this.name
}

output "server_fqdn" {
  description = "The FQDN of the PostgreSQL Flexible Server"
  value       = azurerm_postgresql_flexible_server.this.fqdn
}

output "connection_string" {
  description = "The connection string for the PostgreSQL server"
  value       = "postgresql://${var.admin_user}:${var.admin_pass}@${azurerm_postgresql_flexible_server.this.fqdn}:5432/postgres"
  sensitive   = true
}

output "database_name" {
  description = "The default database name"
  value       = "postgres"
}

output "admin_username" {
  description = "The administrator username"
  value       = var.admin_user
  sensitive   = true
}

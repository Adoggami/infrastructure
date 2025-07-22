output "function_app_name" {
  description = "Nome della Function App creata"
  value       = module.func_petcatalog.function_app_name
}

output "function_app_url" {
  description = "URL della Function App"
  value       = "https://${module.func_petcatalog.function_app_name}.azurewebsites.net"
}

output "storage_account_name" {
  description = "Nome dello Storage Account per i media"
  value       = module.storage_media.name
}

output "postgres_server_name" {
  description = "Nome del server PostgreSQL"
  value       = module.postgres_dev.server_name
}

output "postgres_server_fqdn" {
  description = "FQDN del server PostgreSQL"
  value       = module.postgres_dev.server_fqdn
}

output "postgres_connection_string" {
  description = "Connection string per PostgreSQL"
  value       = module.postgres_dev.connection_string
  sensitive   = true
}
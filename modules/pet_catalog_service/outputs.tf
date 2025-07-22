output "function_app_name" {
  description = "Nome della Function App"
  value       = azurerm_linux_function_app.this.name
}

output "function_app_id" {
  description = "ID della Function App"
  value       = azurerm_linux_function_app.this.id
}

output "function_app_url" {
  description = "URL della Function App"
  value       = "https://${azurerm_linux_function_app.this.name}.azurewebsites.net"
}

output "service_plan_id" {
  description = "ID del Service Plan"
  value       = azurerm_service_plan.plan.id
}

resource "azurerm_service_plan" "plan" {
  name                = "${var.name}-plan"
  resource_group_name = var.rg_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.sku_name    # Parametrizzato
  tags                = var.tags
}

resource "azurerm_linux_function_app" "this" {
  name                       = var.name
  resource_group_name        = var.rg_name
  location                   = var.location
  service_plan_id            = azurerm_service_plan.plan.id
  storage_account_name       = var.sa_name
  storage_account_access_key = var.sa_key
  https_only                 = true      # Miglioramento sicurezza
  tags                       = var.tags

  site_config {
    application_stack {
      python_version = "3.11"
    }
    
    # Miglioramenti sicurezza base
    minimum_tls_version = "1.2"
    ftps_state          = "Disabled"
  }

  app_settings = merge({
    FUNCTIONS_WORKER_RUNTIME = "python"
    POSTGRES_CONN            = var.postgres_conn
    WEBSITE_RUN_FROM_PACKAGE = "1"
  }, var.extra_settings)
}

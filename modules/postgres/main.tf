resource "azurerm_postgresql_flexible_server" "this" {
  name                   = var.name
  resource_group_name    = var.rg_name
  location               = var.location
  sku_name               = var.sku_name
  administrator_login    = var.admin_user
  administrator_password = var.admin_pass
  storage_mb             = var.storage_mb
  version                = "15"
  
  tags                   = var.tags
}

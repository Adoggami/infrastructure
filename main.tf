resource "azurerm_resource_group" "project" {
  name     = "rg-adoggami-prod"
  location = "westeurope"
}
module "storage_media" {
  source   = "./modules/storage"
  name     = "stmediaadoggamiprod"
  rg_name  = azurerm_resource_group.project.name
  location = "westeurope"  # Explicit location
}
module "postgres_dev" {
  source     = "./modules/postgres"
  name       = "pg-adoggami-prod"
  rg_name    = azurerm_resource_group.project.name
  location   = "westeurope"  # Explicit location
  admin_user = var.pg_admin
  admin_pass = var.pg_pass
}
module "func_petcatalog" {
  source        = "./modules/pet_catalog_service"
  name          = "func-petcatalog-prod"
  rg_name       = azurerm_resource_group.project.name
  location      = "westeurope"  # Explicit location
  sa_name       = module.storage_media.name
  sa_key        = module.storage_media.primary_access_key
  postgres_conn = module.postgres_dev.connection_string
}

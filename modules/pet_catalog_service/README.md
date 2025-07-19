# Pet Catalog Service Module

Questo modulo crea un'Azure Function App per il servizio di catalogo animali.

## Risorse create

- Azure Service Plan (Consumption)
- Azure Linux Function App con Node.js

## Input

| Nome          | Descrizione                             | Tipo   | Default |
|---------------|----------------------------------------|--------|---------|
| name          | Nome della Function App                | string | -       |
| rg_name       | Nome del Resource Group                | string | -       |
| location      | Location Azure per le risorse          | string | -       |
| sa_name       | Nome dello Storage Account             | string | -       |
| sa_key        | Chiave di accesso allo Storage Account | string | -       |
| postgres_conn | Stringa di connessione a PostgreSQL    | string | -       |
| extra_settings | Impostazioni app aggiuntive           | map    | {}      |
| tags          | Tag da applicare alle risorse          | map    | {}      |

## Utilizzo

```hcl
module "func_petcatalog" {
  source        = "./modules/pet_catalog_service"
  name          = "func-petcatalog-dev"
  rg_name       = azurerm_resource_group.project.name
  location      = var.location
  sa_name       = module.storage_media.name
  sa_key        = module.storage_media.primary_access_key
  postgres_conn = module.postgres_dev.connection_string
  tags          = local.common_tags
}
```

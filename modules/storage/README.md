# Storage Module

Questo modulo crea un account di storage Azure e un container per le foto.

## Risorse create

- Azure Storage Account
- Storage Container per le foto

## Input

| Nome      | Descrizione                         | Tipo   | Default |
|-----------|-------------------------------------|--------|---------|
| name      | Nome dell'account di storage        | string | -       |
| rg_name   | Nome del Resource Group             | string | -       |
| location  | Location Azure per le risorse       | string | -       |
| tags      | Tag da applicare alle risorse       | map    | {}      |

## Output

| Nome               | Descrizione                             |
|--------------------|-----------------------------------------|
| name               | Nome dell'account di storage creato     |
| primary_access_key | Chiave di accesso primaria allo storage |

## Utilizzo

```hcl
module "storage_media" {
  source   = "./modules/storage"
  name     = "stmediaadoggami"
  rg_name  = azurerm_resource_group.project.name
  location = var.location
  tags     = local.common_tags
}
```

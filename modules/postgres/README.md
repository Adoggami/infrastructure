# PostgreSQL Module

Questo modulo crea un server PostgreSQL Flexible Server per l'applicazione.

## Risorse create

- Azure PostgreSQL Flexible Server

## Input

| Nome      | Descrizione                        | Tipo   | Default |
|-----------|-----------------------------------|--------|---------|
| name      | Nome del server PostgreSQL        | string | -       |
| rg_name   | Nome del Resource Group           | string | -       |
| location  | Location Azure per le risorse     | string | -       |
| admin_user| Username amministratore PostgreSQL| string | -       |
| admin_pass| Password amministratore PostgreSQL| string | -       |
| tags      | Tag da applicare alle risorse     | map    | {}      |

## Output

| Nome               | Descrizione                             |
|--------------------|-----------------------------------------|
| connection_string  | Stringa di connessione al database      |

## Utilizzo

```hcl
module "postgres_dev" {
  source     = "./modules/postgres"
  name       = "pg-adoggami-dev"
  rg_name    = azurerm_resource_group.project.name
  location   = var.location
  admin_user = var.pg_admin
  admin_pass = var.pg_pass
  tags       = local.common_tags
}
```

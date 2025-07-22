 
# Adoggami ‑ Infrastruttura *dev* con Terraform

> **Scopo:** definire e mantenere *Infrastructure‑as‑Code* per l’MVP di Adoggami (serverless su Azure).
>
> **Stato attuale:** Resource Group importato in state remoto; prossimi step → Storage foto, Postgres, prima Function App *PetCatalog*.

---

## 1. Prerequisiti

| Strumento | Versione minima | Comando rapido                  |
| --------- | --------------- | ------------------------------- |
| Terraform | `>= 1.7`        | `brew/winget install terraform` |
| Azure CLI | `>= 2.58`       | `brew/winget install azure-cli` |

```bash
az login                               # autenticazione browser
az account set --subscription <SUB_ID> # scegli subscription corretta
```

---

## 2. Struttura repo

```text
adoggami/
└─ infra/
   ├─ backend.tf         ← configurazione state remoto
   ├─ versions.tf        ← provider azurerm
   ├─ variables.tf       ← credenziali Postgres (pg_admin, pg_pass)
   ├─ main.tf            ← orchestrazione moduli
   └─ modules/
       ├─ rg/            ← Resource Group (importato)
       ├─ storage/       ← Storage foto cani
       ├─ postgres/      ← DB Flexible Server
       └─ function_app/  ← Function App riusabile
```

---

## 3. Backend state remoto

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-adoggami-dev"
    storage_account_name = "sttfadoggami"
    container_name       = "tfstate"
    key                  = "adoggami.dev.tfstate"
  }
}
```

*Container `tfstate` creato a mano nel portal.*

---

## 4. Moduli

### 4.1 Resource Group *(importato)*

```hcl
resource "azurerm_resource_group" "project" {
  name     = "rg-adoggami-dev"
  location = "westeurope"
}
```

> Import:
>
> ```bash
> terraform import azurerm_resource_group.project \
>   /subscriptions/<SUB_ID>/resourceGroups/rg-adoggami-dev
> ```

---

### 4.2 Storage ‑ *media*

```hcl
module "storage_media" {
  source   = "./modules/storage"
  name     = "stmediaadoggami"
  rg_name  = azurerm_resource_group.project.name
  location = azurerm_resource_group.project.location
}
```

* Crea Storage Account + container `photos` privato.
* Output: `name`, `primary_access_key` (usati dalle Functions).

---

### 4.3 Postgres ‑ *Flexible Server B1ms*

```hcl
variable "pg_admin" {}
variable "pg_pass"  { sensitive = true }

module "postgres_dev" {
  source     = "./modules/postgres"
  name       = "pg-adoggami-dev"
  rg_name    = azurerm_resource_group.project.name
  location   = azurerm_resource_group.project.location
  admin_user = var.pg_admin
  admin_pass = var.pg_pass
}
```

* Output: `connection_string` passato alle Functions.

---

### 4.4 Function App ‑ *PetCatalog*

```hcl
module "func_petcatalog" {
  source         = "./modules/function_app"
  name           = "func-petcatalog-dev"
  rg_name        = azurerm_resource_group.project.name
  location       = azurerm_resource_group.project.location
  sa_name        = module.storage_media.name
  sa_key         = module.storage_media.primary_access_key
  postgres_conn  = module.postgres_dev.connection_string
}
```

* Service Plan consumption (`Y1`)
* App settings inject: `POSTGRES_CONN`, `FUNCTIONS_WORKER_RUNTIME=node`.

---

## 5. Workflow di deploy

```bash
# inizializzazione (una sola volta)
terraform init

# crea Storage
terraform apply -target=module.storage_media

# crea Postgres
terraform apply -target=module.postgres_dev

# crea Service Plan + Function App
terraform apply -target=module.func_petcatalog

# (in CI, rimuovi -target e applica tutto insieme)
```

> **Publis**h del codice Function:
>
> ```bash
> cd services/petcatalog
> func azure functionapp publish func-petcatalog-dev
> ```

---

## 6. Prossimi step

| Microservizio       | Modulo                                | Note                                        |
| ------------------- | ------------------------------------- | ------------------------------------------- |
| MediaService        | `function_app` clone                  | usa lo stesso Storage, output URL thumbnail |
| SwipeMatch          | `function_app` + Cosmos DB serverless |                                             |
| Favorites           | `function_app` + Table Storage        |                                             |
| Chat                | `function_app` + SignalR module       |                                             |
| Event orchestration | `event_grid_topic` + subscription     | publish/subscribe fra Functions             |

---

## 7. Convenzioni & best practice

* **Regione unica** `westeurope` per latenza minima.
* **Tag obbligatori** (da aggiungere): `env`, `project`, `owner`.
* **Secrets**: evitare plaintext nei `.tf`; usare Azure Key Vault o var d’ambiente.
* **CI/CD**: GitHub Actions → `terraform plan` on PR, `apply` on merge.

---

*Ultimo aggiornamento: 2025‑07‑19*

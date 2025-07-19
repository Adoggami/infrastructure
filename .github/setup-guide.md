# Configurazione di Service Principal per GitHub Actions

Questo documento spiega come configurare un Service Principal in Azure per permettere a GitHub Actions di deployare l'infrastruttura.

## Passo 1: Creare un Service Principal in Azure

```bash
# Login ad Azure
az login

# Crea il Service Principal con ruolo Contributor
az ad sp create-for-rbac --name "github-adoggami-terraform" --role Contributor --scopes /subscriptions/4a49631f-b836-438d-aa22-9c59716657f1 --sdk-auth
```

L'output sarà simile a questo:
```json
{
  "clientId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "clientSecret": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "subscriptionId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "tenantId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  ...
}
```

## Passo 2: Configurare i Secret in GitHub

Vai su GitHub, nel tuo repository:
1. Vai su "Settings" > "Secrets and variables" > "Actions"
2. Aggiungi i seguenti secrets:

- `AZURE_CLIENT_ID`: Il clientId dal JSON
- `AZURE_CLIENT_SECRET`: Il clientSecret dal JSON
- `AZURE_SUBSCRIPTION_ID`: Il subscriptionId dal JSON
- `AZURE_TENANT_ID`: Il tenantId dal JSON
- `PG_ADMIN`: Username per PostgreSQL
- `PG_PASS`: Password per PostgreSQL

## Come funziona la pipeline

1. Si attiva quando c'è un push sul branch main o una PR verso main
2. Verifica se il backend state esiste già, altrimenti lo crea
3. Su PR: esegue `terraform plan` per verificare le modifiche
4. Su push a main: esegue `terraform apply` per applicare le modifiche

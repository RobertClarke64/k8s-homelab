# Home Kubernetes

A GitOps-managed Kubernetes homelab using ArgoCD, with automated dependency management via Renovate.

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         ArgoCD                                  │
│                    (GitOps Controller)                          │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                        root-app                                 │
│              (Helm chart generating Applications)               │
└─────────────────────────────────────────────────────────────────┘
                              │
        ┌─────────────────────┼─────────────────────┐
        ▼                     ▼                     ▼
   ┌─────────┐          ┌─────────┐          ┌─────────┐
   │  Apps   │          │  Infra  │          │  Observ │
   │         │          │  Core   │          │  Stack  │
   └─────────┘          └─────────┘          └─────────┘
```

### Key Components

- **ArgoCD** - GitOps continuous deployment
- **KGateway** - Kubernetes Gateway API for ingress
- **MetalLB** - Bare-metal load balancer
- **CloudNativePG** - PostgreSQL operator
- **Infisical + External-Secrets** - Secrets management
- **Prometheus, Loki, Grafana, Alloy** - Observability stack

### Networking

- **Domain**: `*.robertclarke.co.uk`
- **Gateway IP**: `192.168.1.244`
- **MetalLB Pool**: `192.168.1.241-254`
- **TLS**: Let's Encrypt via cert-manager

## Directory Structure

```
home-kubernetes/
├── root-app/              # Meta Helm chart - generates ArgoCD Applications
│   ├── values.yaml        # List of all managed applications
│   └── templates/
├── infra-core/            # Core infrastructure (argocd, cert-manager, etc.)
├── observability/         # Monitoring stack (grafana, prometheus, loki, alloy)
├── [app-directories]/     # Individual application Helm charts
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
├── .github/workflows/     # CI pipelines
└── renovate.json          # Automated dependency updates
```

## How It Works

### App of Apps Pattern

The `root-app` Helm chart reads `values.yaml` and generates an ArgoCD `Application` resource for each entry. ArgoCD then deploys and manages each application independently.

### Adding a New Application

1. Create a directory with a Helm chart:
   ```
   my-app/
   ├── Chart.yaml
   ├── values.yaml
   └── templates/
   ```

2. Add to `root-app/values.yaml`:
   ```yaml
   applications:
     my-app: {}
   ```

3. Push to main - ArgoCD handles the rest.

### Secrets

Applications use `ExternalSecret` resources that pull from Infisical and create Kubernetes Secrets automatically.

### CI/CD

- **Renovate** creates PRs for dependency updates (Helm charts, container images)
- **GitHub Actions** runs `helm diff` on PRs to preview changes
- **ArgoCD** syncs changes from main with self-healing enabled

## Local Development

```bash
# Template a chart locally
helm template my-app ./my-app

# Diff against deployed version
helm diff upgrade my-app ./my-app -n my-app
```

## Storage

All persistent storage uses the `unraid-nfs-named` storage class backed by NFS.

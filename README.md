# 🚀 Portfolio Infrastructure

Infrastructure as Code (Terraform) para deploy do meu portfólio na AWS.

## Arquitetura

- **EC2** `t2.micro` (Free Tier) com Amazon Linux 2023
- **Nginx** como web server
- **Elastic IP** para IP público fixo
- **Security Group** liberando HTTP (80) e SSH (22)
- **Região**: `sa-east-1` (São Paulo)

## Pré-requisitos

- [Terraform](https://www.terraform.io/downloads) >= 1.5.0
- Conta AWS com credenciais configuradas
- GitHub repo com secrets configuradas (ver abaixo)

## Deploy Local

```bash
terraform init
terraform plan
terraform apply
```

## CI/CD

O deploy é automatizado via **GitHub Actions**:

| Evento | Ação |
|--------|------|
| Pull Request → `main` | `terraform plan` + comentário no PR |
| Push → `main` | `terraform apply` automático |

## Secrets Necessárias no GitHub

Configure em: **Settings → Secrets and variables → Actions**

| Secret | Descrição |
|--------|-----------|
| `AWS_ACCESS_KEY_ID` | Access Key do IAM user |
| `AWS_SECRET_ACCESS_KEY` | Secret Key do IAM user |

## Outputs

| Nome | Descrição |
|------|-----------|
| `public_ip` | IP público do servidor |
| `instance_id` | ID da instância EC2 |

## Estrutura

```
.
├── .github/workflows/terraform.yml
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
├── .gitignore
└── README.md
```

## Custos

- EC2 `t2.micro`: **grátis** (Free Tier, 12 meses)
- Elastic IP associado: **grátis**
- Elastic IP não associado: ~$3.65/mês

## License

MIT

# 🚀 Portfolio Infrastructure

Infrastructure as Code (Terraform) para deploy do portfólio na AWS.

## Arquitetura

- **EC2** `t3.micro` com Amazon Linux 2023
- **Caddy** como web server (configurado via Ansible)
- **Elastic IP** para IP público fixo (`56.126.174.29`)
- **Security Group** liberando HTTP (80), HTTPS (443) e SSH (22)
- **Key Pair** para acesso SSH
- **Região**: `sa-east-1` (São Paulo)
- **State**: S3 backend (`portfolio-tfstate-194772390844`)

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

| Secret | Usado por | Descrição |
|--------|-----------|-----------|
| `AWS_ACCESS_KEY_ID` | terraform, ansible | Access Key do IAM user |
| `AWS_SECRET_ACCESS_KEY` | terraform, ansible | Secret Key do IAM user |
| `SSH_PRIVATE_KEY` | ansible, lucaspadilhacom | Chave privada SSH (`portfolio-key`) |
| `SERVER_IP` | lucaspadilhacom | IP público do servidor (`56.126.174.29`) |

## Outputs

| Nome | Descrição |
|------|-----------|
| `public_ip` | IP público do servidor |
| `instance_id` | ID da instância EC2 |

## Repositórios Relacionados

| Repo | Propósito |
|------|-----------|
| [aws-ansible](https://github.com/lucasgpadilha/aws-ansible) | Configuração do servidor (Caddy, HTTPS, updates) |
| [lucaspadilhacom](https://github.com/lucasgpadilha/lucaspadilhacom) | Código fonte do site (Astro + React) |

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

- EC2 `t3.micro`: **grátis** (Free Tier, 12 meses)
- Elastic IP associado: **grátis**
- Elastic IP não associado: ~$3.65/mês

## License

MIT

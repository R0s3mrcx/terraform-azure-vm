# Terraform Azure VM

![Terraform](https://img.shields.io/badge/Terraform-844FBA?logo=terraform&logoColor=white)
![Azure](https://img.shields.io/badge/Azure-0078D4?logo=microsoftazure&logoColor=white)
![License](https://img.shields.io/github/license/r0s3mrcx/terraform-azure-vm)

Provision Azure infrastructure on Microsoft Azure using Terraform.

The project deploys a Resource Group, Virtual Network, Subnet, Network Security Group, Public IP, Network Interface, and an Ubuntu Linux Virtual Machine.

# Architecture

```
Terraform
     │
     ▼
Resource Group
     │
     ▼
Virtual Network
     │
     ├─────────────┐
     ▼             ▼
 Subnet      Network Security Group
     │             │
     └──────┬──────┘
            ▼
   Network Interface
            │
      ┌─────┴─────┐
      ▼           ▼
 Public IP    Linux VM
```

# Resources Created

- Resource Group
- Virtual Network
- Subnet
- Network Security Group (allows inbound SSH on port 22, only from the IP you set)
- Public IP (Static, Standard SKU)
- Network Interface
- Linux Virtual Machine (Ubuntu 22.04 LTS)

All resources that support it are tagged (`environment`, `project`) for cost tracking. Subnets are the one exception - Azure doesn't support tags on subnets.

# Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.5.0
- [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli) installed and authenticated (`az login`)
- An active Azure subscription
- An SSH key pair (`ssh-keygen -t rsa -b 4096`)

# Project Structure

```
terraform-azure-vm/
│
├── main.tf                      # Provider + all Azure resources
├── variables.tf                 # Input variables and defaults
├── outputs.tf                   # Values printed after apply
├── terraform.tfvars.example     # Example variable values
├── .github/workflows/ci.yml     # Format + validate on every push
├── README.md
└── .gitignore
```

# How to Run

Clone the repository:

```bash
git clone https://github.com/r0s3mrcx/terraform-azure-vm.git
cd terraform-azure-vm
```

Log in to Azure:

```bash
az login
```

Copy the example variables file and adjust it with your own values.
`allowed_ssh_source` has no default on purpose - you must set it, or `terraform plan` will
stop and ask for it. This prevents accidentally leaving SSH open to the whole internet.

```bash
cp terraform.tfvars.example terraform.tfvars
```

Initialize Terraform:

```bash
terraform init
```

Preview the changes:

```bash
terraform plan
```

Apply the changes:

```bash
terraform apply
```

Connect to the VM using the output command:

```bash
terraform output ssh_connection_command
```

Destroy all resources when you're done (avoid unnecessary Azure costs):

```bash
terraform destroy
```

# CI

Every push runs a GitHub Actions workflow that checks:

1. **`terraform fmt -check`** - code is formatted correctly
2. **`terraform validate`** - the configuration is syntactically valid

No Azure credentials are required because the workflow only checks formatting and validates the configuration. It does not create any Azure resources. 
See [`.github/workflows/ci.yml`](.github/workflows/ci.yml).

# Variables

| Name | Description | Default |
|---|---|---|
| `project_name` | Prefix used to name all resources | `terraform-azure-vm` |
| `resource_group_name` | Name of the Resource Group | `rg-terraform-azure-vm` |
| `location` | Azure region | `West Europe` |
| `vnet_address_space` | Address space for the VNet | `10.0.0.0/16` |
| `subnet_address_prefix` | Address prefix for the Subnet | `10.0.1.0/24` |
| `allowed_ssh_source` | Source IP/CIDR allowed to SSH into the VM | **required, no default** |
| `vm_size` | Azure VM size | `Standard_B1s` |
| `admin_username` | Admin username for the VM | `azureuser` |
| `ssh_public_key_path` | Local path to your SSH public key | `~/.ssh/id_rsa.pub` |
| `tags` | Tags applied to resources that support them | `{ environment = "learning", project = "terraform-azure-vm" }` |

# Outputs

| Name | Description |
|---|---|
| `resource_group_name` | Name of the created Resource Group |
| `vm_public_ip` | Public IP address of the VM |
| `vm_private_ip` | Private IP address of the VM |
| `ssh_connection_command` | Ready-to-use SSH command |

# Future Improvements

- Remote state backend (Azure Storage)
- Terraform modules
- Multiple environments (dev/staging/prod) with `.tfvars` files

# License

This project is licensed under the MIT License. See the `LICENSE` file for details.

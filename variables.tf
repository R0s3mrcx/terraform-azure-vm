variable "project_name" {
  description = "Prefix used to name all resources"
  type        = string
  default     = "terraform-azure-vm"
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "rg-terraform-azure-vm"
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "West Europe"
}

variable "vnet_address_space" {
  description = "Address space for the Virtual Network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_address_prefix" {
  description = "Address prefix for the Subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "allowed_ssh_source" {
  description = "Source IP or CIDR allowed to connect via SSH. No default on purpose: you must set your own public IP (e.g. 1.2.3.4/32) in terraform.tfvars. This forces a conscious choice instead of accidentally leaving SSH open to the whole internet."
  type        = string
}

variable "vm_size" {
  description = "Size of the Virtual Machine"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for the Linux VM"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  description = "Local path to your SSH public key (e.g. ~/.ssh/id_rsa.pub)"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "tags" {
  description = "Tags applied to every resource that supports them (useful for cost tracking)"
  type        = map(string)
  default = {
    environment = "learning"
    project     = "terraform-azure-vm"
  }
}

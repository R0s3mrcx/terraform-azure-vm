output "resource_group_name" {
  description = "Name of the created Resource Group"
  value       = azurerm_resource_group.main.name
}

output "vm_public_ip" {
  description = "Public IP address of the Linux VM"
  value       = azurerm_public_ip.main.ip_address
}

output "vm_private_ip" {
  description = "Private IP address of the Linux VM"
  value       = azurerm_network_interface.main.private_ip_address
}

output "ssh_connection_command" {
  description = "Ready-to-use SSH command to connect to the VM"
  value       = "ssh ${var.admin_username}@${azurerm_public_ip.main.ip_address}"
}

# Output the public IP addresses of the VMs
output "vm1_public_ip" {
  description = "Public IP address of VM 1"
  value       = azurerm_public_ip.vm1_public_ip.ip_address
}

output "vm2_public_ip" {
  description = "Public IP address of VM 2"
  value       = azurerm_public_ip.vm2_public_ip.ip_address
}

# Output the private IP addresses of the VMs
output "vm1_private_ip" {
  description = "Private IP address of VM 1"
  value       = azurerm_network_interface.vm1_nic.private_ip_address
}

output "vm2_private_ip" {
  description = "Private IP address of VM 2"
  value       = azurerm_network_interface.vm2_nic.private_ip_address
}
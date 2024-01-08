output "aws_public_ip" {
  value = aws_instance.public-server.public_ip
}

output "aws_private_ip" {
  value = aws_instance.public-server.private_ip
}

output "gcp_public_ip" {
  value = google_compute_address.vm.address
}

output "gcp_private_ip" {
  value = google_compute_instance.vm.network_interface.0.network_ip
}
output "azure_public_ip" {
  value = azurerm_linux_virtual_machine.ubuntu.public_ip_address
}

output "azure_private_ip" {
  value = azurerm_network_interface.nic.private_ip_addresses
}
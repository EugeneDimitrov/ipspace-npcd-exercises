#main module outputs

output "public_ip" {
  value       = module.network.public_ip
  description = "public ip of instance"
}

output "location" {
  value       = azurerm_resource_group.tf_rg.location
}

output "rg_name" {
  value    = azurerm_resource_group.tf_rg.name
}
#main module outputs

#filter information about vm name and public address
locals {
  vm_information = zipmap(keys(module.network.public_ip), [for vm_name, vm_parameter in module.network.public_ip : vm_parameter.ip_address])
}

output "vm_information" {
  value       = local.vm_information
  description = "Prints information about VM name and public IP address"
}
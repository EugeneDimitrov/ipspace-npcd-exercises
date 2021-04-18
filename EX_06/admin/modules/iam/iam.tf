# access control (iam) part of Azure infrastructure

##############################
#get user ids
##############################

data "azuread_user" "tf_user_mclimp" {
  user_principal_name = var.tf_user_mclimp
}

##############################
#assign roles to users
##############################

#assign RO role to RG for user mclimp

#resource "azurerm_role_assignment" "tf_role_assignment_reader" {
#  scope                = var.rg_id
#  role_definition_name = "Reader"
#  principal_id         = data.azuread_user.tf_user_mclimp.object_id
#}

#assign Network Contributor role to RG for user mclimp

#resource "azurerm_role_assignment" "tf_role_assignment_netw_contr" {
#  scope                = var.rg_id
#  role_definition_name = "Network Contributor"
#  principal_id         = data.azuread_user.tf_user_mclimp.object_id
#}

#assign Storage Blob Data Owner to RG for user mclimp

#resource "azurerm_role_assignment" "tf_role_assignment_storage_owner" {
#  scope                = var.rg_id
#  role_definition_name = "Storage Blob Data Owner"
#  principal_id         = data.azuread_user.tf_user_mclimp.object_id
#}

#assign Virtual Machine Contributor to RG for user mclimp

#resource "azurerm_role_assignment" "tf_role_assignment_vm_contributor" {
#  scope                = var.rg_id
#  role_definition_name = "Virtual Machine Contributor"
#  principal_id         = data.azuread_user.tf_user_mclimp.object_id
#}
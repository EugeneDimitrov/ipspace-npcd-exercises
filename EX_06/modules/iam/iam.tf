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

resource "azurerm_role_assignment" "tf_role_assignment_ro" {
  scope                = var.rg_id
  role_definition_name = "Reader"
  principal_id         = data.azuread_user.tf_user_mclimp.object_id
}
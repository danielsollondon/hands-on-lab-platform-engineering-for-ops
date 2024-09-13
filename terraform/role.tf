resource "azurerm_role_assignment" "dev_center" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Owner"
  principal_id         = azurerm_dev_center.this.identity[0].principal_id
}

resource "azurerm_role_assignment" "dev_center_key_vault_secret_user" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_dev_center.this.identity[0].principal_id
}

resource "azurerm_role_assignment" "users_key_vault_secret_user" {
  for_each             = local.users_index
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azuread_user.this[each.key].id
}

resource "azurerm_role_assignment" "dev_center_rg_contributor" {
  for_each             = local.users_index
  scope                = azurerm_resource_group.this.id
  role_definition_name = "Contributor"
  principal_id         = azuread_user.this[each.key].id
}

resource "azurerm_role_assignment" "dev_center_rg_user_access_administrator" {
  for_each             = local.users_index
  scope                = azurerm_resource_group.this.id
  role_definition_name = "User Access Administrator"
  principal_id         = azuread_user.this[each.key].id
}

resource "azurerm_role_assignment" "subscription_user_access_administrator" {
  for_each             = local.users_index
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "User Access Administrator"
  principal_id         = azuread_user.this[each.key].id
}

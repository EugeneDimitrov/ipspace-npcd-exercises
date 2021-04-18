# network part of Azure infrastructure deploying resource group, vnet, subnets, nic ...

########################
# create virtual network
########################

resource "azurerm_virtual_network" "tf_vnet" {
  name                = var.network_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = var.network_ip
}

###############
#create subnets
###############

resource "azurerm_subnet" "tf_web_subnet" {
  name                 = var.web_sub_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.tf_vnet.name
  address_prefixes     = var.web_sub_address
}

resource "azurerm_subnet" "tf_db_subnet" {
  name                 = var.db_sub_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.tf_vnet.name
  address_prefixes     = var.db_sub_address
}

resource "azurerm_subnet" "tf_jh_subnet" {
  name                 = var.jh_sub_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.tf_vnet.name
  address_prefixes     = var.jh_sub_address
}

resource "azurerm_subnet" "tf_appgw_subnet" {
  name                 = var.appgw_sub_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.tf_vnet.name
  address_prefixes     = var.appgw_sub_address
}

#################
#create public ip
#################

resource "azurerm_public_ip" "tf_pub_ip_1" {
  name                = var.pub_ip_name_1
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"
  allocation_method   = var.pub_ip_method
  domain_name_label   = "appgw"
}

resource "azurerm_public_ip" "tf_pub_ip_2" {
  name                = var.pub_ip_name_2
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = var.pub_ip_method
}

##############################
#create network interface card
##############################

resource "azurerm_network_interface" "tf_jh_nic_1" {
  name                = var.jh_nic_name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = var.jh_nic_ip_conf_name
    subnet_id                     = azurerm_subnet.tf_jh_subnet.id
    public_ip_address_id          = azurerm_public_ip.tf_pub_ip_2.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "tf_web_nic_1" {
  name                = var.web_nic_name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = var.web_nic_ip_conf_name
    subnet_id                     = azurerm_subnet.tf_web_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "tf_db_nic_1" {
  name                = var.db_nic_name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = var.db_nic_ip_conf_name
    subnet_id                     = azurerm_subnet.tf_db_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

##############################
#create application gateway
##############################

#create waf policy

resource "azurerm_web_application_firewall_policy" "ft_waf_policy" {
  name                = "WafGlobalPolicy"
  resource_group_name = var.rg_name
  location            = var.location

  custom_rules {
    name      = "Rule100"
    priority  = 100
    rule_type = "MatchRule"

    match_conditions {
      match_variables {
        variable_name = "RequestUri"
      }
      operator           = "Contains"
      negation_condition = false
      match_values       = ["admin", "login"]
      transforms         = ["Lowercase"]
    }
    action = "Block"
  }

  policy_settings {
    enabled                     = true
    mode                        = "Prevention"
    request_body_check          = true
    file_upload_limit_in_mb     = 100
    max_request_body_size_in_kb = 128
  }

  managed_rules {
    managed_rule_set {
      type    = "OWASP"
      version = "3.1"
    }
  }
}

#create local variables for application gateway creation

locals {
  sku_name                       = "WAF_v2"
  sku_tier                       = "WAF_v2"
  gateway_ip_configuration_name  = "appgwipcfg"
  backend_address_pool_name      = "beap"
  frontend_port_name             = "feport"
  frontend_ip_configuration_name = "feip"
  http_setting_name              = "be-htst"
  listener_name                  = "httplstn"
  request_routing_rule_name      = "rqrt"
  redirect_configuration_name    = "rdrcfg"
}

resource "azurerm_application_gateway" "tf_app_gw" {
  name                = var.appgw_name
  resource_group_name = var.rg_name
  location            = var.location
  firewall_policy_id  = azurerm_web_application_firewall_policy.ft_waf_policy.id

  sku {
    name = local.sku_name
    tier = local.sku_tier
  }
  autoscale_configuration {
    min_capacity = "0"
    max_capacity = "2"
  }

  gateway_ip_configuration {
    name      = local.gateway_ip_configuration_name
    subnet_id = azurerm_subnet.tf_appgw_subnet.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.tf_pub_ip_1.id
  }

  backend_address_pool {
    name         = local.backend_address_pool_name
    ip_addresses = [azurerm_network_interface.tf_web_nic_1.ip_configuration[0].private_ip_address]
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
}
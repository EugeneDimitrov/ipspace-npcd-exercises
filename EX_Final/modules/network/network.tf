# network part of Azure infrastructure deploying resource group, vnet, subnets, nic ...

########################
# create virtual networks
########################

resource "azurerm_virtual_network" "vnet_vng_gwc" {
  name                = "VNET_VNG_${var.name_prefix_gwc}"
  location            = var.loc_gwc
  resource_group_name = var.rg_name_gwc
  address_space       = var.network_ip_vnet_vng_gwc
}

resource "azurerm_virtual_network" "vnet_vng_ne" {
  name                = "VNET_VNG_${var.name_prefix_ne}"
  location            = var.loc_ne
  resource_group_name = var.rg_name_ne
  address_space       = var.network_ip_vnet_vng_ne
}

resource "azurerm_virtual_network" "vnet_maas_gwc" {
  name                = "VNET_MAAS_${var.name_prefix_gwc}"
  location            = var.loc_gwc
  resource_group_name = var.rg_name_gwc
  address_space       = var.network_ip_vnet_maas_gwc
}

resource "azurerm_virtual_network" "vnet_maas_ne" {
  name                = "VNET_MAAS_${var.name_prefix_ne}"
  location            = var.loc_ne
  resource_group_name = var.rg_name_ne
  address_space       = var.network_ip_vnet_maas_ne
}

###############
#create subnets
###############

resource "azurerm_subnet" "subnet_vng_gwc" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.rg_name_gwc
  virtual_network_name = azurerm_virtual_network.vnet_vng_gwc.name
  address_prefixes     = var.sub_address_vng_gwc
}

resource "azurerm_subnet" "subnet_vng_ne" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.rg_name_ne
  virtual_network_name = azurerm_virtual_network.vnet_vng_ne.name
  address_prefixes     = var.sub_address_vng_ne
}

resource "azurerm_subnet" "subnet_app_gwc" {
  name                 = "Sub_App_${var.name_prefix_gwc}"
  resource_group_name  = var.rg_name_gwc
  virtual_network_name = azurerm_virtual_network.vnet_maas_gwc.name
  address_prefixes     = var.sub_address_app_gwc
}

resource "azurerm_subnet" "subnet_app_ne" {
  name                 = "Sub_App_${var.name_prefix_ne}"
  resource_group_name  = var.rg_name_ne
  virtual_network_name = azurerm_virtual_network.vnet_maas_ne.name
  address_prefixes     = var.sub_address_app_ne
}

resource "azurerm_subnet" "subnet_db_gwc" {
  name                 = "Sub_DB_${var.name_prefix_gwc}"
  resource_group_name  = var.rg_name_gwc
  virtual_network_name = azurerm_virtual_network.vnet_maas_gwc.name
  address_prefixes     = var.sub_address_db_gwc
}

resource "azurerm_subnet" "subnet_db_ne" {
  name                 = "Sub_DB_${var.name_prefix_ne}"
  resource_group_name  = var.rg_name_ne
  virtual_network_name = azurerm_virtual_network.vnet_maas_ne.name
  address_prefixes     = var.sub_address_db_ne
}

resource "azurerm_subnet" "subnet_jh_gwc" {
  name                 = "Sub_Jumphost_${var.name_prefix_gwc}"
  resource_group_name  = var.rg_name_gwc
  virtual_network_name = azurerm_virtual_network.vnet_maas_gwc.name
  address_prefixes     = var.sub_address_jh_gwc
}

#################
#create vnet peerings
#################

#create peer in RG-GWC-MAAS between local maas vnet and local VNG

resource "azurerm_virtual_network_peering" "peer_gwc_maas_gwc_vng" {
  name                      = "${azurerm_virtual_network.vnet_maas_gwc.name}_To_${azurerm_virtual_network.vnet_vng_gwc.name}"
  resource_group_name       = var.rg_name_gwc
  virtual_network_name      = azurerm_virtual_network.vnet_maas_gwc.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_vng_gwc.id
}

resource "azurerm_virtual_network_peering" "peer_gwc_vng_gwc_maas" {
  name                      = "${azurerm_virtual_network.vnet_vng_gwc.name}_To_${azurerm_virtual_network.vnet_maas_gwc.name}"
  resource_group_name       = var.rg_name_gwc
  virtual_network_name      = azurerm_virtual_network.vnet_vng_gwc.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_maas_gwc.id
}

#create peer in RG-NE-MAAS between local maas vnet and local VNG

resource "azurerm_virtual_network_peering" "peer_ne_maas_ne_vng" {
  name                      = "${azurerm_virtual_network.vnet_maas_ne.name}_To_${azurerm_virtual_network.vnet_vng_ne.name}"
  resource_group_name       = var.rg_name_ne
  virtual_network_name      = azurerm_virtual_network.vnet_maas_ne.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_vng_ne.id
}

resource "azurerm_virtual_network_peering" "peer_ne_vng_ne_maas" {
  name                      = "${azurerm_virtual_network.vnet_vng_ne.name}_To_${azurerm_virtual_network.vnet_maas_ne.name}"
  resource_group_name       = var.rg_name_ne
  virtual_network_name      = azurerm_virtual_network.vnet_vng_ne.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_maas_ne.id
}

#create global peer between maas in RG-GWC-MAAS and maas in RG-NE-MAAS

resource "azurerm_virtual_network_peering" "peer_gwc_maas_ne_maas" {
  name                      = "${azurerm_virtual_network.vnet_maas_gwc.name}_To_${azurerm_virtual_network.vnet_maas_ne.name}"
  resource_group_name       = var.rg_name_gwc
  virtual_network_name      = azurerm_virtual_network.vnet_maas_gwc.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_maas_ne.id

  allow_gateway_transit = false
}

resource "azurerm_virtual_network_peering" "peer_ne_maas_gwc_maas" {
  name                      = "${azurerm_virtual_network.vnet_maas_ne.name}_To_${azurerm_virtual_network.vnet_maas_gwc.name}"
  resource_group_name       = var.rg_name_ne
  virtual_network_name      = azurerm_virtual_network.vnet_maas_ne.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_maas_gwc.id

  allow_gateway_transit = false
}


#################
#create public ips
#################

resource "azurerm_public_ip" "pub_ip_vng_gwc" {
  name                = "VNG_Pub_IP_${var.name_prefix_gwc}"
  location            = var.loc_gwc
  resource_group_name = var.rg_name_gwc
  allocation_method   = "Dynamic"
}

resource "azurerm_public_ip" "pub_ip_vng_ne" {
  name                = "VNG_Pub_IP_${var.name_prefix_ne}"
  location            = var.loc_ne
  resource_group_name = var.rg_name_ne
  allocation_method   = "Dynamic"
}

resource "azurerm_public_ip" "pub_ip_jh_gwc" {
  name                = "JH_Pub_IP_${var.name_prefix_gwc}"
  location            = var.loc_gwc
  resource_group_name = var.rg_name_gwc
  allocation_method   = "Dynamic"
  domain_name_label   = "jmpmaas"
}

##############################
#create network interface cards
##############################

resource "azurerm_network_interface" "jh_nic_gwc" {
  name                = "JH_NIC_${var.name_prefix_gwc}"
  location            = var.loc_gwc
  resource_group_name = var.rg_name_gwc

  ip_configuration {
    name                          = "JH_IP_CFG_${var.name_prefix_gwc}"
    subnet_id                     = azurerm_subnet.subnet_jh_gwc.id
    private_ip_address_version    = "IPv4"
    public_ip_address_id          = azurerm_public_ip.pub_ip_jh_gwc.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "app_nic_gwc" {
  name                = "App_NIC_${var.name_prefix_gwc}"
  location            = var.loc_gwc
  resource_group_name = var.rg_name_gwc

  ip_configuration {
    name                          = "App_IP_CFG_${var.name_prefix_gwc}"
    subnet_id                     = azurerm_subnet.subnet_app_gwc.id
    private_ip_address_version    = "IPv4"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "app_nic_ne" {
  name                = "App_NIC_${var.name_prefix_ne}"
  location            = var.loc_ne
  resource_group_name = var.rg_name_ne

  ip_configuration {
    name                          = "App_IP_CFG_${var.name_prefix_ne}"
    subnet_id                     = azurerm_subnet.subnet_app_ne.id
    private_ip_address_version    = "IPv4"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "db_nic_gwc" {
  name                = "DB_NIC_${var.name_prefix_gwc}"
  location            = var.loc_gwc
  resource_group_name = var.rg_name_gwc

  ip_configuration {
    name                          = "DB_IP_CFG_${var.name_prefix_gwc}"
    subnet_id                     = azurerm_subnet.subnet_db_gwc.id
    private_ip_address_version    = "IPv4"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "db_nic_ne" {
  name                = "DB_NIC_${var.name_prefix_ne}"
  location            = var.loc_ne
  resource_group_name = var.rg_name_ne

  ip_configuration {
    name                          = "DB_IP_CFG_${var.name_prefix_ne}"
    subnet_id                     = azurerm_subnet.subnet_db_ne.id
    private_ip_address_version    = "IPv4"
    private_ip_address_allocation = "Dynamic"
  }
}




#################
#create vng
#################
/*
resource "azurerm_virtual_network_gateway" "vng_gwc" {
  name                = "VNG_${var.name_prefix_gwc}"
  location            = var.loc_gwc
  resource_group_name = var.rg_name_gwc

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = true
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "IP_CFG_VNG_${var.name_prefix_gwc}"
    public_ip_address_id          = azurerm_public_ip.pub_ip_vng_gwc.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.subnet_vng_gwc.id
  }
}

resource "azurerm_virtual_network_gateway" "vng_ne" {
  name                = "VNG_${var.name_prefix_ne}"
  location            = var.loc_ne
  resource_group_name = var.rg_name_ne

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = true
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "IP_CFG_VNG_${var.name_prefix_ne}"
    public_ip_address_id          = azurerm_public_ip.pub_ip_vng_ne.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.subnet_vng_ne.id
  }
}
*/
# computation part of Azure infrastructure

######################
#create jumphost VM
######################

resource "azurerm_linux_virtual_machine" "vm_jh_gwc" {
  name                  = "VM_JH_${var.name_prefix_gwc}"
  location              = var.loc_gwc
  resource_group_name   = var.rg_name_gwc
  network_interface_ids = ["${var.jh_nic_id_gwc}"]
  size                  = "Standard_B1s"

  computer_name                   = "jh-${var.name_prefix_gwc}"
  admin_username                  = var.admin_user
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_user
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    name                 = "JH_Disk_${var.name_prefix_gwc}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}

######################
#create Application VMs
######################

resource "azurerm_linux_virtual_machine" "vm_app_gwc" {
  name                  = "VM_App_${var.name_prefix_gwc}"
  location              = var.loc_gwc
  resource_group_name   = var.rg_name_gwc
  network_interface_ids = ["${var.app_nic_id_gwc}"]
  size                  = "Standard_B2s"

  computer_name                   = "app-${var.name_prefix_gwc}"
  admin_username                  = var.admin_user
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_user
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    name                 = "App_Disk_${var.name_prefix_gwc}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}

resource "azurerm_linux_virtual_machine" "vm_app_ne" {
  name                  = "VM_App_${var.name_prefix_ne}"
  location              = var.loc_ne
  resource_group_name   = var.rg_name_ne
  network_interface_ids = ["${var.app_nic_id_ne}"]
  size                  = "Standard_B2s"

  computer_name                   = "app-${var.name_prefix_ne}"
  admin_username                  = var.admin_user
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_user
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    name                 = "App_Disk_${var.name_prefix_ne}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}

######################
#create Database VMs
######################


resource "azurerm_linux_virtual_machine" "vm_db_gwc" {
  name                  = "VM_DB_${var.name_prefix_gwc}"
  location              = var.loc_gwc
  resource_group_name   = var.rg_name_gwc
  network_interface_ids = ["${var.db_nic_id_gwc}"]
  size                  = "Standard_D2s_v3"

  computer_name                   = "db-act"
  admin_username                  = var.admin_user
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_user
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    name                 = "DB_Disk_${var.name_prefix_gwc}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}

resource "azurerm_linux_virtual_machine" "vm_db_ne" {
  name                  = "VM_DB_${var.name_prefix_ne}"
  location              = var.loc_ne
  resource_group_name   = var.rg_name_ne
  network_interface_ids = ["${var.db_nic_id_ne}"]
  size                  = "Standard_D2s_v3"

  computer_name                   = "db-stb"
  admin_username                  = var.admin_user
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_user
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    name                 = "DB_Disk_${var.name_prefix_ne}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}

######################
#generate inventory file for ansible using template
######################

data "azurerm_public_ip" "pub_ip_jh_gwc" {
  name                = "JH_Pub_IP_${var.name_prefix_gwc}"
  resource_group_name = var.rg_name_gwc
}

data "azurerm_network_interface" "jh_nic_gwc" {
  name                = "JH_NIC_${var.name_prefix_gwc}"
  resource_group_name = var.rg_name_gwc
}

data "azurerm_network_interface" "app_nic_gwc" {
  name                = "App_NIC_${var.name_prefix_gwc}"
  resource_group_name = var.rg_name_gwc
}

data "azurerm_network_interface" "app_nic_ne" {
  name                = "App_NIC_${var.name_prefix_ne}"
  resource_group_name = var.rg_name_ne
}

data "azurerm_network_interface" "db_nic_gwc" {
  name                = "DB_NIC_${var.name_prefix_gwc}"
  resource_group_name = var.rg_name_gwc
}

data "azurerm_network_interface" "db_nic_ne" {
  name                = "DB_NIC_${var.name_prefix_ne}"
  resource_group_name = var.rg_name_ne
}

resource "local_file" "ansible_hosts" {
  content = templatefile("${path.module}/templates/ansible_hosts.tpl",
    {
     app_ip_gwc  = data.azurerm_network_interface.app_nic_gwc.ip_configuration[0].private_ip_address
     app_ip_ne   = data.azurerm_network_interface.app_nic_ne.ip_configuration[0].private_ip_address
     db_ip_gwc   = data.azurerm_network_interface.db_nic_gwc.ip_configuration[0].private_ip_address
     db_ip_ne    = data.azurerm_network_interface.db_nic_ne.ip_configuration[0].private_ip_address
     jh_ip_gwc    = data.azurerm_network_interface.jh_nic_gwc.ip_configuration[0].private_ip_address

     admin_user  = var.admin_user
     jh_dns_name = data.azurerm_public_ip.pub_ip_jh_gwc.fqdn
    }
  )
  filename = "ansible/hosts"
}
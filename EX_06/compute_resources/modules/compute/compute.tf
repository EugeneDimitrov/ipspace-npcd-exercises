# computation part of Azure infrastructure

######################
#create Web VM
######################

resource "azurerm_linux_virtual_machine" "tf_web_vm" {
  name                  = var.web_vm_name
  location              = var.location
  resource_group_name   = var.rg_name
  network_interface_ids = var.web_nic_id
  size                  = var.web_vm_size

  computer_name                   = var.web_vm_name
  admin_username                  = var.admin_user
  disable_password_authentication = true
  custom_data                     = data.template_cloudinit_config.tf_cloudinit_web_config.rendered

  admin_ssh_key {
    username   = var.admin_user
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    name                 = "${var.web_vm_name}_disk"
    caching              = var.os_disk_caching
    storage_account_type = var.web_os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
}

######################
#create Database VM
######################

resource "azurerm_linux_virtual_machine" "tf_db_vm" {
  name                  = var.db_vm_name
  location              = var.location
  resource_group_name   = var.rg_name
  network_interface_ids = var.db_nic_id
  size                  = var.db_vm_size

  computer_name                   = var.db_vm_name
  admin_username                  = var.admin_user
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_user
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    name                 = "${var.db_vm_name}_disk"
    caching              = var.os_disk_caching
    storage_account_type = var.db_os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
}

######################
#create Jumphost VM
######################

resource "azurerm_linux_virtual_machine" "tf_jh_vm" {
  name                  = var.jh_vm_name
  location              = var.location
  resource_group_name   = var.rg_name
  network_interface_ids = var.jh_nic_id
  size                  = var.jh_vm_size

  computer_name                   = var.jh_vm_name
  admin_username                  = var.admin_user
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_user
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    name                 = "${var.jh_vm_name}_disk"
    caching              = var.os_disk_caching
    storage_account_type = var.jh_os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
}

######################
#generate cloudinit config using template
######################

data "template_file" "tf_script_web_vm" {
  template = file("${path.module}/templates/cloud_init_web.tpl")

  vars = {
    server_name = var.web_vm_name
    server_ip   = var.web_private_ip
    user        = var.admin_user
  }
}

data "template_cloudinit_config" "tf_cloudinit_web_config" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = data.template_file.tf_script_web_vm.rendered
  }
}
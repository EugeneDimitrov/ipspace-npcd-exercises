# computation part of Azure infrastructure

######################
#create Linux VM
######################

resource "azurerm_linux_virtual_machine" "tf_vm" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.rg_name
  network_interface_ids = var.nic_id
  size                  = var.vm_size

  computer_name                   = var.vm_name
  admin_username                  = var.admin_user
  disable_password_authentication = true
  custom_data                     = data.template_cloudinit_config.tf_cloudinit_config.rendered

  admin_ssh_key {
    username   = var.admin_user
    public_key = file("~/.ssh/id_rsa_azure.pub")
  }

  os_disk {
    name                 = "${var.vm_name}_disk"
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
}

######################
#render cloudinit config using template
######################

data "template_file" "tf_script" {
  template = file("${path.module}/cloud_init.tpl")

  vars = {
    server_name = var.vm_name
    server_ip   = var.private_ip
    user        = var.admin_user
    img         = var.img
  }
}

data "template_cloudinit_config" "tf_cloudinit_config" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = data.template_file.tf_script.rendered
  }
}
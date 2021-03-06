# computation part of Azure infrastructure

######################
#create Linux VM
######################

resource "azurerm_virtual_machine" "tf_vm" {
  for_each = var.vms

  name                  = each.key
  location              = var.location
  resource_group_name   = var.rg_name
  network_interface_ids = [var.tf_nic[each.key].id]
  vm_size               = each.value

  os_profile {
    computer_name  = each.key
    admin_username = var.admin_user
  }

  storage_os_disk {
    name          = "${each.key}_disk"
    create_option = "FromImage"
  }

  storage_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/${var.admin_user}/.ssh/authorized_keys"
      key_data = file("~/.ssh/id_rsa.pub")
    }
  }

  provisioner "remote-exec" {
    inline = ["sudo apt install -y python3"]

    connection {
      host        = var.public_ip[each.key].ip_address
      type        = "ssh"
      user        = var.admin_user
      private_key = file("~/.ssh/id_rsa")
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook -u '${var.admin_user}' -i '${var.public_ip[each.key].ip_address},' --private-key '~/.ssh/id_rsa' provision.yml"
  }

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true
}
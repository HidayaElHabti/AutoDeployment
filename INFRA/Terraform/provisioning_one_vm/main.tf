locals {
  resource_group = "app-grp"
  location       = "North Europe"
}

resource "azurerm_resource_group" "resgrp_app" {
  name     = local.resource_group
  location = var.region
}

resource "azurerm_virtual_network" "app-network" {
  name                = "app-network"
  location            = local.location
  resource_group_name = azurerm_resource_group.resgrp_app.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "app_subnet" {
  name                 = "mySubnet"
  resource_group_name  = azurerm_resource_group.resgrp_app.name
  virtual_network_name = azurerm_virtual_network.app-network.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "app-interface" {
  name                = "app-interface"
  location            = local.location
  resource_group_name = azurerm_resource_group.resgrp_app.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.app_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.app_public_ip.id
  }

}


resource "azurerm_linux_virtual_machine" "my_machine" {
  name                = "appvm"
  resource_group_name = azurerm_resource_group.resgrp_app.name
  location            = local.location
  size                = "Standard_DS1_v2"
  admin_username      = "adminuser"
  admin_password      = "User@user123!"
  network_interface_ids = [
    azurerm_network_interface.app-interface.id
  ]
  disable_password_authentication = false
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }


  depends_on = [
    azurerm_network_interface.app-interface
  ]
}

resource "azurerm_public_ip" "app_public_ip" {
  name = "app-public-ip"
  resource_group_name = azurerm_resource_group.resgrp_app.name
  location = local.location
  allocation_method = "Static"

}

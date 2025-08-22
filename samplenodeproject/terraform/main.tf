provider "azurerm" {
  features {}
    client_id       = var.client_id
    client_secret   = var.client_secret
    tenant_id       = var.tenant_id
    subscription_id = var.subscription_id

}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-lewisc-1"
  location = "UK South"  # change as needed
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "rs-lewisc-vm-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Network Security Group
resource "azurerm_network_security_group" "nsg" {
  name                = "rs-lewisc-vm-tf-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# NSG Rule (Allow SSH)
resource "azurerm_network_security_rule" "ssh" {
  name                        = "Allow-SSH"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

# NSG Rule (Allow Jenkins on Port 8080)
resource "azurerm_network_security_rule" "jenkins" {
  name                        = "Allow-Jenkins"
  priority                    = 1002
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "8080"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

# NSG Rule (Allow HTTP on Port 80)
resource "azurerm_network_security_rule" "http" {
  name                        = "Allow-HTTP"
  priority                    = 1003
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

# NSG Rule (Allow app to run on Port 5000)
resource "azurerm_network_security_rule" "app" {
  name                        = "Allow-App"
  priority                    = 1004
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "5000"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

# Network Interface
resource "azurerm_network_interface" "nic" {
  name                = "rs-lewisc-vm897-tf"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
  
  
}

resource "azurerm_public_ip" "public_ip" {
  name                       = "rs-lewisc-vm-tf-ip"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  allocation_method          = "Static"  # Set allocation method to Static
  sku                         = "Standard"  # Use Standard SKU for public IP
  idle_timeout_in_minutes    = 4           # Optional: set idle timeout (default is 4)
  
  tags = {
    environment = "production"
  }
}

resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Virtual Machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "rs-lewisc-tf-vm"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = "Standard_B1s"
  admin_username        = "azureuser"
  network_interface_ids = [azurerm_network_interface.nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "osdisk-rs-lewisc-vm"
  }
   source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"  # Updated offer name
    sku       = "server"             # The plan (SKU)
    version   = "latest"             # Use 'latest' for Ubuntu 24.04 LTS
  }

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")  # Update path to your SSH public key
  }

  disable_password_authentication = true
}

resource "azurerm_virtual_machine_extension" "custom_script" {
  name                 = "customScript"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"
  settings = <<SETTINGS
    {
      "script": "${base64encode(data.template_file.init_script.rendered)}"
    }
  SETTINGS
  depends_on = [azurerm_linux_virtual_machine.vm]
}

data "template_file" "init_script" {
  template = file("init.sh")
}
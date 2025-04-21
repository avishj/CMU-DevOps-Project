provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

# Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = var.virtual_network_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = [var.address_space]
}

# Subnet
resource "azurerm_subnet" "internal" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.subnet_address_prefixes]
}

# Network Security Group (NSG)
resource "azurerm_network_security_group" "main" {
  name                = "${var.resource_group_name}-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Associate the NSG with the subnet - traffic to/from VMs in this subnet is filtered
resource "azurerm_subnet_network_security_group_association" "rule" {
  subnet_id                 = azurerm_subnet.internal.id
  network_security_group_id = azurerm_network_security_group.main.id
}

# Public IP Address for VM 1
resource "azurerm_public_ip" "vm1_public_ip" {
  name                = "${var.resource_group_name}-vm1-public-ip"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Dynamic" # Or "Static" for a fixed IP
}

# Public IP Address for VM 2
resource "azurerm_public_ip" "vm2_public_ip" {
  name                = "${var.resource_group_name}-vm2-public-ip"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Dynamic" # Or "Static" for a fixed IP
}

# Network Interface for VM 1
resource "azurerm_network_interface" "vm1_nic" {
  name                = "${var.resource_group_name}-vm1-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm1_public_ip.id
  }
}

# Network Interface for VM 2
resource "azurerm_network_interface" "vm2_nic" {
  name                = "${var.resource_group_name}-vm2-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm2_public_ip.id
  }
}


# Virtual Machine 1
resource "azurerm_linux_virtual_machine" "vm1" {
  name                = "${var.resource_group_name}-vm1"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [azurerm_network_interface.vm1_nic.id] # Associate NIC 1

  # Define SSH access
  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_public_key # Use the public key variable
  }

  # OS Disk configuration
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # Source Image
  source_image_reference {
    publisher = var.vm_image_publisher
    offer     = var.vm_image_offer
    sku       = var.vm_image_sku
    version   = var.vm_image_version
  }
}

# Virtual Machine 2
resource "azurerm_linux_virtual_machine" "vm2" {
  name                = "${var.resource_group_name}-vm2"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [azurerm_network_interface.vm2_nic.id] # Associate NIC 2

  # Define SSH access
  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_public_key # Use the public key variable
  }

  # OS Disk configuration
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # Source Image
  source_image_reference {
    publisher = var.vm_image_publisher
    offer     = var.vm_image_offer
    sku       = var.vm_image_sku
    version   = var.vm_image_version
  }
}
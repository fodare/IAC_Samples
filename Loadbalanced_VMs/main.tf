terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}

resource "azurerm_resource_group" "az_resourcegroup" {
  name     = "${var.environment_name}-${var.resource_groupName}"
  location = var.resource_groupLocation
  tags = {
    "Environment" : var.environment_name
  }
}

resource "azurerm_virtual_network" "az_virtualnetwork" {
  name                = "${var.environment_name}-${var.vitual_networkName}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.az_resourcegroup.location
  resource_group_name = azurerm_resource_group.az_resourcegroup.name
  tags = {
    "Environment" : var.environment_name
  }
}

resource "azurerm_subnet" "az_subnet" {
  name                 = "${var.resource_groupName}-${var.virtual_subnetName}"
  resource_group_name  = azurerm_resource_group.az_resourcegroup.name
  virtual_network_name = azurerm_virtual_network.az_virtualnetwork.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "az_bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.az_resourcegroup.name
  virtual_network_name = azurerm_virtual_network.az_virtualnetwork.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_security_group" "az_netsecugroup" {
  name                = "${var.environment_name}-${var.netoek_securitygorup}"
  location            = azurerm_resource_group.az_resourcegroup.location
  resource_group_name = azurerm_resource_group.az_resourcegroup.name
  tags = {
    "Environment" : var.environment_name
  }
  security_rule {
    name                       = "ssh"
    priority                   = 1022
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "10.0.1.0/24"
  }
  security_rule {
    name                       = "web"
    priority                   = 1080
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "10.0.1.0/24"
  }
}

resource "azurerm_subnet_network_security_group_association" "az_nsg_ass" {
  subnet_id                 = azurerm_subnet.az_subnet.id
  network_security_group_id = azurerm_network_security_group.az_netsecugroup.id
}

resource "azurerm_public_ip" "az_publicip" {
  count               = 2
  name                = "${var.environment_name}-${var.publicip_name}-${count.index}"
  location            = azurerm_resource_group.az_resourcegroup.location
  resource_group_name = azurerm_resource_group.az_resourcegroup.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    "Environment" : var.environment_name
  }
}

resource "azurerm_network_interface" "az_nic" {
  count               = 2
  name                = "${var.network_interface_name}${count.index}"
  location            = azurerm_resource_group.az_resourcegroup.location
  resource_group_name = azurerm_resource_group.az_resourcegroup.name
  tags = {
    "Environment" : var.environment_name
  }
  ip_configuration {
    name                          = "ipconfig${count.index}"
    subnet_id                     = azurerm_subnet.az_subnet.id
    private_ip_address_allocation = "Dynamic"
    primary                       = true
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "az_nic_lb_pool" {
  count                   = 2
  network_interface_id    = azurerm_network_interface.az_nic[count.index].id
  ip_configuration_name   = "ipconfig${count.index}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.az_lb_pool.id
}

resource "azurerm_bastion_host" "my_bastion" {
  name                = "${var.environment_name}-bastion"
  location            = azurerm_resource_group.az_resourcegroup.location
  resource_group_name = azurerm_resource_group.az_resourcegroup.name
  sku                 = "Standard"

  ip_configuration {
    name                 = "ipconfig"
    subnet_id            = azurerm_subnet.az_bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.az_publicip[1].id
  }
  ip_connect_enabled = true
  tunneling_enabled  = true
}

resource "azurerm_linux_virtual_machine" "az_vm" {
  count                 = 2
  name                  = "${var.environment_name}-${var.vm_name}${count.index}"
  location              = azurerm_resource_group.az_resourcegroup.location
  resource_group_name   = azurerm_resource_group.az_resourcegroup.name
  network_interface_ids = [azurerm_network_interface.az_nic[count.index].id]
  size                  = var.vm_size
  tags = {
    "Environment" : var.environment_name
  }
  os_disk {
    name                 = "disk-${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  admin_username = var.vm_username
  admin_password = var.vm_password
  admin_ssh_key {
    username   = var.vm_username
    public_key = file("~/.ssh/id_rsa.pub")
  }
  disable_password_authentication = false
}

resource "azurerm_lb" "az_lb" {
  name                = var.load_balancer_name
  location            = azurerm_resource_group.az_resourcegroup.location
  resource_group_name = azurerm_resource_group.az_resourcegroup.name
  sku                 = "Standard"
  tags = {
    "Environment" : var.environment_name
  }

  frontend_ip_configuration {
    name                 = "${var.environment_name}-${var.load_balancer_name}"
    public_ip_address_id = azurerm_public_ip.az_publicip[0].id
  }
}

resource "azurerm_lb_backend_address_pool" "az_lb_pool" {
  loadbalancer_id = azurerm_lb.az_lb.id
  name            = "${var.environment_name}-${var.load_balancer_pool_name}"
}

resource "azurerm_lb_probe" "az_lb_probe" {
  loadbalancer_id = azurerm_lb.az_lb.id
  name            = "${var.environment_name}-lb-probe"
  port            = 80
}

resource "azurerm_lb_rule" "az_lb_rule" {
  loadbalancer_id                = azurerm_lb.az_lb.id
  name                           = "Port_80"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  disable_outbound_snat          = true
  frontend_ip_configuration_name = "${var.environment_name}-${var.load_balancer_name}"
  probe_id                       = azurerm_lb_probe.az_lb_probe.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.az_lb_pool.id]
}

resource "azurerm_lb_outbound_rule" "az_lboutbound_rule" {
  name                    = "${var.environment_name}-outbound"
  loadbalancer_id         = azurerm_lb.az_lb.id
  protocol                = "Tcp"
  backend_address_pool_id = azurerm_lb_backend_address_pool.az_lb_pool.id

  frontend_ip_configuration {
    name = "${var.environment_name}-${var.load_balancer_name}"
  }
}

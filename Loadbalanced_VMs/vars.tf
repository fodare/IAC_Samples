variable "environment_name" {
  type        = string
  description = "Desired enviroment name."
  default     = "dev"
}

variable "resource_groupName" {
  type        = string
  description = "Desired resource group name. Note environment name is appened to name."
  default     = "rg"
}

variable "resource_groupLocation" {
  type        = string
  description = "Desired resource group location."
  default     = "EAST US"
}

variable "vitual_networkName" {
  type        = string
  description = "Desired virtual network name. Note environment tag is append to name."
  default     = "virtualNetwork"
}

variable "virtual_subnetName" {
  type        = string
  description = "Desired virtual subnet name. Note environment name is appened to name."
  default     = "subnet"
}

variable "netoek_securitygorup" {
  type        = string
  description = "Desired security group name. Note environment name will be appended to name."
  default     = "security-group"
}

variable "publicip_name" {
  type        = string
  description = "Desired public ip resource name. Note environment name will be appened to name."
  default     = "publicip"
}

variable "nat_gateway_name" {
  type        = string
  description = "Desired nat gateway name. Note environment name is appended to name."
  default     = "natgateway"
}

variable "network_interface_name" {
  type        = string
  description = "Desired network interface  name. Note enviroment name is appended to name."
  default     = "nwtworkinterface"
}

variable "vm_name" {
  type        = string
  description = "Desired VM name. Note environment name is appended to name."
  default     = "webserver"
}

variable "vm_password" {
  type        = string
  description = "Desired vm password."
}

variable "vm_size" {
  type        = string
  description = "Desired virtual machine size."
  default     = "Standard_B2s"
}

variable "vm_username" {
  type        = string
  description = "Desired VM name."
  default     = "adminUser"
}

variable "load_balancer_name" {
  type        = string
  description = "Desired load balancer name. Note environment name appened to name."
  default     = "loadbalancer"
}

variable "load_balancer_pool_name" {
  type        = string
  description = "Desired load balancer pool name. Note environment name is appended to name."
  default     = "lb-pool"
}



variable "desired_resource_group_name" {
  description = "Desired resource group name. Note -rg is appended to desired name."
  default     = "test"
  type        = string
}

variable "desired_resource_location" {
  description = "Desired resource group location"
  default     = "EAST US"
  type        = string
}

variable "virtual_network_name" {
  description = "Desired virtual network name. Note -vn is appended to name."
  default     = "test"
  type        = string
}

variable "virtual_subenet_name" {
  description = "Desired subnet name. Note -sn is appended to name."
  type        = string
  default     = "test"
}

variable "public_ip_name" {
  description = "Desired public ip name. Note -pip is appened to name."
  default     = "test"
  type        = string
}

variable "desired_network_interface_name" {
  description = "Desired network interface name. Note -pip is appened to name."
  default     = "test"
  type        = string
}

variable "desired_network_security_group_name" {
  description = "Desired network security group name. Note -sg is appened to name."
  default     = "test"
  type        = string

}

variable "virtual_machine_name" {
  description = "Desired virtual machine name. Note -vm is appened to name."
  type        = string
  default     = "test"
}

variable "virtual_machine_size" {
  description = "Desired virtual machine size."
  default     = "Standard_B1ls"
  type        = string
}

variable "virtual_machine_userName" {
  description = "Virtual machine user name."
  default     = "adminuser"
  type        = string
}

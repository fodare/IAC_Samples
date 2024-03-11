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

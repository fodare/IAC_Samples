variable "resource_groupName" {
  type        = string
  description = "Desired resource group name"
  default     = "test-rg"
}

variable "resource_groupLocation" {
  type        = string
  description = "Desired resource group location"
  default     = "West Europe"
}

variable "storage_account_name" {
  type        = string
  description = "Desired storage account name"
  default     = "test-sa"
}

variable "service_plan_name" {
  type        = string
  description = "Desired service plan name"
  default     = "test_sp"
}

variable "azure_function_name" {
  type        = string
  description = "Desired function app name"
  default     = "azure_devops_func"
}

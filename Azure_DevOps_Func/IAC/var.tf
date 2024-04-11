variable "resource_group_name" {
  type        = string
  default     = "test-rg"
  description = "Desired resource group name"
}

variable "resource_group_location" {
  type        = string
  default     = "EAST US"
  description = "Desired resource group location"
}

variable "stroage_account_name" {
  type        = string
  description = "Desired storage account name"
  default     = "testfunctiondevops"
}

variable "service_plan_name" {
  type        = string
  default     = "azure_devOps_func_sp"
  description = "Desired service plan name"
}

variable "function_app_name" {
  type        = string
  default     = "azure-devOps-func"
  description = "Desired function app namea"
}

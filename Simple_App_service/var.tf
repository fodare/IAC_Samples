variable "resource_group_name" {
  description = "Desired resource group name"
  type        = string
  default     = "test-rg"
}

variable "resource_group_location" {
  description = "Desired resource group location"
  type        = string
  default     = "EAST US"
}

variable "service_plan_name" {
  description = "Desired service principle name"
  type        = string
  default     = "test-sp"
}

variable "service_sku_name" {
  description = "Desired service plan sku. Possible values are: B1, B2, B3, D1, F1, FREE, I1, I1v2, I2, I2v2, I3, I3v2, I4v2, I5v2, I6v2, P0V3, P1MV3, P1V2, P1V3, P2MV3, P2V2, P2V3, P3MV3, P3V2, P3V3, P4MV3, P5MV3, S1, S2, S3, SHARED, WS1, WS2, WS3"
  default     = "F1"
}

variable "app_service_name" {
  description = "Desired app service name"
  type        = string
  default     = "testwiseapp-as"
}

variable "app_service_environment_tag" {
  description = "Desired environment tag"
  type        = string
  default     = "DEV"
}

variable "application_stack_version" {
  description = "Desired application stack version. Run az webapp list-runtimes --linux to see possible values."
  type        = string
  default     = "3.10"
}

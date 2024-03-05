variable "node_count" {
  description = "Number of node running in the kunbernetes cluster"
  default     = 1
}

variable "cluster_name" {
  description = "Desired cluster name. Note k8s is appended to name."
  type        = string
}

variable "node_name" {
  description = "Desired node name"
  type        = string
}

variable "node_vm_size" {
  description = "Desired node virtual machine size"
  type        = string
  default     = "Standard_D2_v2"
}

variable "environment_tag" {
  description = "Desired environment tag"
  type        = string
}

variable "resource_group_name" {
  description = "Desired resource group name"
  type        = string
}

variable "resource_group_location" {
  description = "Desired resource group location"
  type        = string
  default     = "NORTH EUROPE"
}

variable "subscription_id" {
  description = "Azure subscription ID. Supply through TF_VAR_subscription_id or a secure pipeline variable."
  type        = string
  sensitive   = true
}

variable "location" {
  description = "Azure region for the foundation resources."
  type        = string
  default     = "Central India"
}

variable "name_prefix" {
  description = "Short lowercase prefix used to create globally unique resource names where required."
  type        = string
  default     = "raja-platform"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "environment must be dev, test, or prod."
  }
}

variable "owner" {
  description = "Team or owner responsible for the resources."
  type        = string
  default     = "platform-engineering"
}

variable "address_space" {
  description = "VNet address space; ensure it does not overlap with connected networks."
  type        = list(string)
  default     = ["10.40.0.0/16"]
}

variable "subnet_prefixes" {
  description = "Workload subnet prefixes within the VNet address space."
  type        = list(string)
  default     = ["10.40.1.0/24"]
}

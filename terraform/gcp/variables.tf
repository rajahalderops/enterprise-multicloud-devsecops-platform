variable "project_id" {
  description = "Existing GCP project ID with billing enabled."
  type        = string
}

variable "region" {
  description = "GCP region for foundation resources."
  type        = string
  default     = "asia-south1"
}

variable "name_prefix" {
  description = "Short lowercase resource-name prefix."
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

variable "subnet_cidr" {
  description = "Subnet CIDR; ensure it does not overlap with connected networks."
  type        = string
  default     = "10.50.1.0/24"
}

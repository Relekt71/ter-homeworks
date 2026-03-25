variable "env_name" {
  description = "Environment name"
  type        = string
}

variable "subnets" {
  description = "List of subnets with zone and CIDR blocks"
  type = list(object({
    zone = string
    cidr = string
  }))
  
  validation {
    condition = alltrue([
      for subnet in var.subnets : can(regex("^ru-central1-[abdek]$", subnet.zone))
    ])
    error_message = "Each zone must be one of: ru-central1-a, ru-central1-b, ru-central1-d, ru-central1-e, ru-central1-k."
  }
  
  validation {
    condition = alltrue([
      for subnet in var.subnets : can(cidrhost(subnet.cidr, 0))
    ])
    error_message = "Each CIDR block must be a valid IPv4 CIDR."
  }
}

variable "labels" {
  description = "Labels for VPC resources"
  type        = map(string)
  default     = {}
}
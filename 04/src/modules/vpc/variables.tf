variable "env_name" {
  description = "Environment name (e.g., develop, staging, production)"
  type        = string
  
  validation {
    condition     = can(regex("^[a-z0-9_-]+$", var.env_name))
    error_message = "Environment name must contain only lowercase letters, numbers, hyphens, and underscores."
  }
}

variable "subnets" {
  description = "List of subnets with zone and CIDR blocks"
  type = list(object({
    zone = string
    cidr = string
  }))
  
  validation {
    condition = alltrue([
      for subnet in var.subnets : can(regex("^ru-central1-[abcd]$", subnet.zone))
    ])
    error_message = "Zone must be one of: ru-central1-a, ru-central1-b, ru-central1-c, ru-central1-d."
  }
  
  validation {
    condition = alltrue([
      for subnet in var.subnets : can(cidrhost(subnet.cidr, 0))
    ])
    error_message = "All CIDR blocks must be valid IPv4 CIDR blocks."
  }
}

variable "create_network" {
  description = "Whether to create a new VPC network"
  type        = bool
  default     = true
}

variable "existing_network_id" {
  description = "ID of existing VPC network to use (if create_network is false)"
  type        = string
  default     = ""
}

variable "zone" {
  description = "Default availability zone (used if not specified in subnets)"
  type        = string
  default     = "ru-central1-a"
}
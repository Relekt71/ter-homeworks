variable "name" {
  description = "Security group name"
  type        = string
}

variable "description" {
  description = "Security group description"
  type        = string
}

variable "network_id" {
  description = "Network ID"
  type        = string
}

variable "labels" {
  description = "Security group labels"
  type        = map(string)
  default     = {}
}

variable "ingress_rules" {
  description = "Ingress rules"
  type = list(object({
    protocol       = string
    description    = string
    v4_cidr_blocks = list(string)
    port           = number
  }))
  default = []
}

variable "egress_rules" {
  description = "Egress rules"
  type = list(object({
    protocol       = string
    description    = string
    v4_cidr_blocks = list(string)
    port           = number
  }))
  default = []
}

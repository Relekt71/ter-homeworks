output "network_id" {
  description = "ID of the VPC network"
  value       = local.network_id
}

output "network_name" {
  description = "Name of the VPC network"
  value       = var.create_network ? yandex_vpc_network.this[0].name : "existing-network"
}

output "subnet_ids" {
  description = "List of subnet IDs"
  value       = yandex_vpc_subnet.this[*].id
}

output "subnet_names" {
  description = "List of subnet names"
  value       = yandex_vpc_subnet.this[*].name
}

output "subnets_info" {
  description = "Complete information about all subnets"
  value = [
    for i, subnet in yandex_vpc_subnet.this : {
      id          = subnet.id
      name        = subnet.name
      zone        = subnet.zone
      cidr        = subnet.v4_cidr_blocks[0]
      network_id  = subnet.network_id
      network_name = var.create_network ? yandex_vpc_network.this[0].name : "existing-network"
    }
  ]
}
output "network_id" {
  description = "ID of the created VPC network"
  value       = yandex_vpc_network.this.id
}

output "network_name" {
  description = "Name of the created VPC network"
  value       = yandex_vpc_network.this.name
}

output "subnets" {
  description = "Map of created subnets with zone as key"
  value = {
    for idx, subnet in yandex_vpc_subnet.this :
    subnet.zone => {
      id         = subnet.id
      name       = subnet.name
      zone       = subnet.zone
      cidr       = subnet.v4_cidr_blocks[0]
      network_id = subnet.network_id
    }
  }
}

output "subnet_ids" {
  description = "List of subnet IDs"
  value       = [for subnet in yandex_vpc_subnet.this : subnet.id]
}
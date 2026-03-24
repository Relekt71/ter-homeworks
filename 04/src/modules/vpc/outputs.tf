output "network_id" {
  value = yandex_vpc_network.this.id
}

output "network_name" {
  value = yandex_vpc_network.this.name
}

output "subnet_id" {
  value = yandex_vpc_subnet.this.id
}

output "subnet_cidr" {
  value = yandex_vpc_subnet.this.v4_cidr_blocks[0]
}

output "zone" {
  value = yandex_vpc_subnet.this.zone
}
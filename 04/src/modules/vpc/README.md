<!-- BEGIN_TF_DOCS -->
# VPC Module for Yandex Cloud

## Описание

Локальный модуль для создания VPC сети и подсети в Yandex Cloud.
Модуль создает одну сеть и одну подсеть в указанной зоне.

## Требования

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| random | ~> 3.5 |
| yandex | ~> 0.92 |

## Входные переменные

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cidr | CIDR block for subnet | `string` | n/a | yes |
| env\_name | Environment name | `string` | n/a | yes |
| zone | Availability zone | `string` | n/a | yes |

## Выходные данные

## Outputs

| Name | Description |
|------|-------------|
| network\_id | n/a |
| network\_name | n/a |
| subnet\_cidr | n/a |
| subnet\_id | n/a |
| zone | n/a |

## Пример использования

```hcl
module "vpc_dev" {
  source   = "./modules/vpc"
  env_name = "develop"
  zone     = "ru-central1-a"
  cidr     = "10.0.1.0/24"
}

# Использование выходных данных
resource "yandex_compute_instance" "vm" {
  subnet_id = module.vpc_dev.subnet_id
}
<!-- END_TF_DOCS -->
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Modules

No modules.

## Resources

| Name | Type |
|------|------|

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_cidr\_blocks | Additional CIDR blocks for the subnet (optional) | `list(string)` | `[]` | no |
| cidr | CIDR block for the subnet | `string` | n/a | yes |
| env\_name | Environment name (e.g., develop, production) | `string` | n/a | yes |
| zone | Yandex Cloud availability zone | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| network\_id | ID of the created VPC network |
| network\_name | Name of the created VPC network |
| subnet\_cidr | CIDR block of the created subnet |
| subnet\_id | ID of the created subnet |
| subnet\_info | Complete information about the subnet |
| subnet\_name | Name of the created subnet |
| zone | Availability zone of the subnet |
<!-- END_TF_DOCS -->
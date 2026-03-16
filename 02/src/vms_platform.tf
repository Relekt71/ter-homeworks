#variable "vm_web_name" {
#  type        = string
#  default     = "netology-develop-platform-web"
#  description = "Имя веб-сервера"
#}

#variable "vm_web_platform_id" {
#  type        = string
#  default     = "standard-v3"
#  description = "Платформа ВМ"
#}

#variable "vm_web_cores" {
#  type        = number
#  default     = 2
#  description = "Количество ядер ВМ"
#}

#variable "vm_web_memory" {
#  type        = number
#  default     = 2
#  description = "Объем RAM в ГБ"
#}

#variable "vm_web_core_fraction" {
#  type        = number
#  default     = 20
#  description = "Уровень производительности CPU"
#}

#variable "vm_web_preemptible" {
#  type        = bool
#  default     = true
#  description = "Прерываемая ВМ"
#}

#variable "vm_web_nat" {
#  type        = bool
#  default     = true
#  description = "Публичный IP-адрес"
#}

#variable "vm_web_serial_port_enable" {
#  type        = number
#  default     = 1
#  description = "Доступ через serial console"
#}

#variable "vm_web_image_family" {
#  type        = string
#  default     = "ubuntu-2004-lts"
#  description = "Семейство образа ОС для web ВМ"
#}

### Переменные для ВМ базы данных (db)

#variable "vm_db_name" {
#  type        = string
#  default     = "netology-develop-platform-db"
#  description = "Имя сервера базы данных"
#}

#variable "vm_db_platform_id" {
#  type        = string
#  default     = "standard-v3"
#  description = "Платформа ВМ для БД"
#}

#variable "vm_db_cores" {
#  type        = number
#  default     = 2
#  description = "Количество ядер для ВМ БД"
#}

#variable "vm_db_memory" {
#  type        = number
#  default     = 2
#  description = "Объем RAM для ВМ БД в ГБ"
#}

#variable "vm_db_core_fraction" {
#  type        = number
#  default     = 20
#  description = "Уровень производительности CPU для ВМ БД"
#}

#variable "vm_db_preemptible" {
#  type        = bool
#  default     = true
#  description = "Прерываемая ВМ для БД"
#}

#variable "vm_db_nat" {
#  type        = bool
#  default     = true
#  description = "Публичный IP-адрес для ВМ БД"
#}

#variable "vm_db_serial_port_enable" {
#  type        = number
#  default     = 1
#  description = "Доступ через serial console для ВМ БД"
#}

#variable "vm_db_image_family" {
#  type        = string
# default     = "ubuntu-2004-lts"
#  description = "Семейство образа ОС для ВМ БД"
#}

#variable "vm_db_zone" {
#  type        = string
#  default     = "ru-central1-b"
#  description = "Зона доступности для ВМ БД"
# }


### Map-переменные для конфигурации ВМ (Задание 6)

variable "vms_resources" {
  description = "Конфигурация ресурсов для всех ВМ"
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    hdd_size      = number
    hdd_type      = string
    zone          = string
    platform_id   = string
    preemptible   = bool
    nat           = bool
    image_family  = string
  }))
  default = {
    web = {
      cores         = 2
      memory        = 2
      core_fraction = 20
      hdd_size      = 5
      hdd_type      = "network-hdd"
      zone          = "ru-central1-a"
      platform_id   = "standard-v3"
      preemptible   = true
      nat           = true
      image_family  = "ubuntu-2004-lts"
    }
    db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
      hdd_size      = 5
      hdd_type      = "network-hdd"
      zone          = "ru-central1-b"
      platform_id   = "standard-v3"
      preemptible   = true
      nat           = true
      image_family  = "ubuntu-2004-lts"
    }
  }
}

#variable "metadata" {
#  description = "Общие metadata для всех ВМ"
#  type = object({
#    serial-port-enable = number
#    ssh-keys           = string
#  })
#  default = {
#   serial-port-enable = 1
#    ssh-keys = "ubuntu:${var.vms_ssh_root_key}"
#  }
#}
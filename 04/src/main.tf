#создаем облачную сеть
resource "yandex_vpc_network" "develop" {
  name = "develop"
}

#создаем подсеть
resource "yandex_vpc_subnet" "develop_a" {
  name           = "develop-ru-central1-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}

resource "yandex_vpc_subnet" "develop_b" {
  name           = "develop-ru-central1-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.2.0/24"]
}

# Динамическое создание cloud-init с передачей SSH ключа
data "template_file" "cloudinit_marketing" {
  template = file("./cloud-init.yml")
  
  vars = {
    ssh_public_key = var.public_key
    vm_name        = "marketing-vm"
    vm_project     = "marketing"
  }
}

data "template_file" "cloudinit_analytics" {
  template = file("./cloud-init.yml")
  
  vars = {
    ssh_public_key = var.public_key
    vm_name        = "analytics-vm"
    vm_project     = "analytics"
  }
}

# Создание ВМ для marketing проекта
module "marketing_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "marketing"
  network_id     = yandex_vpc_network.develop.id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [yandex_vpc_subnet.develop_a.id]
  instance_name  = "marketing-vm"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = { 
    owner   = "i.ivanov"
    project = "marketing"
    env     = "prod"
    purpose = "web"
  }

  metadata = {
    user-data          = data.template_file.cloudinit_marketing.rendered
    serial-port-enable = 1
  }
}

# Создание ВМ для analytics проекта
module "analytics_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "analytics"
  network_id     = yandex_vpc_network.develop.id
  subnet_zones   = ["ru-central1-b"]
  subnet_ids     = [yandex_vpc_subnet.develop_b.id]
  instance_name  = "analytics-vm"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = { 
    owner   = "i.ivanov"
    project = "analytics"
    env     = "prod"
    purpose = "data-processing"
  }

  metadata = {
    user-data          = data.template_file.cloudinit_analytics.rendered
    serial-port-enable = 1
  }
}

# Вывод информации о ВМ
output "vms_info" {
  value = {
    marketing = {
      fqdn         = module.marketing_vm.fqdn[0]
      external_ip  = module.marketing_vm.external_ip[0]
      internal_ip  = module.marketing_vm.internal_ip[0]
      labels       = module.marketing_vm.labels
    }
    analytics = {
      fqdn         = module.analytics_vm.fqdn[0]
      external_ip  = module.analytics_vm.external_ip[0]
      internal_ip  = module.analytics_vm.internal_ip[0]
      labels       = module.analytics_vm.labels
    }
  }
}

output "marketing_vm_ip" {
  value = module.marketing_vm.external_ip[0]
}

output "analytics_vm_ip" {
  value = module.analytics_vm.external_ip[0]
}
### Get latest OS image
data "yandex_compute_image" "os" {
  family = var.image_family
}
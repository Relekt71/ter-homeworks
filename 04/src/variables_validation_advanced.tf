# Переменная для проверки строки без заглавных букв
variable "lowercase_string" {
  description = "Любая строка (только строчные буквы)"
  type        = string
  
  validation {
    condition     = can(regex("^[a-z0-9_\\-\\s]+$", var.lowercase_string))
    error_message = "Строка должна содержать только строчные буквы, цифры, пробелы, дефисы и подчеркивания. Заглавные буквы не допускаются!"
  }
}

# Переменная для проверки объекта (только один true)
variable "in_the_end_there_can_be_only_one" {
  description = "Who is better Connor or Duncan?"
  type = object({
    Dunkan = optional(bool)
    Connor = optional(bool)
  })

  default = {
    Dunkan = true
    Connor = false
  }

  validation {
    error_message = "There can be only one MacLeod! (Только одно значение может быть true, второе должно быть false)"
    condition = (
      (var.in_the_end_there_can_be_only_one.Dunkan == true && var.in_the_end_there_can_be_only_one.Connor == false) ||
      (var.in_the_end_there_can_be_only_one.Dunkan == false && var.in_the_end_there_can_be_only_one.Connor == true)
    )
  }
}

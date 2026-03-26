## Описание изменений

Исправление кода по результатам анализа checkov.

### Исправленные ошибки checkov:
- **CKV_YC_1** - Добавлен security group для MySQL кластера
- **CKV_YC_11** - Добавлены security groups для network interface ВМ
- **CKV_YC_19** - Security groups не содержат allow-all rules

### Пропущенные проверки (осознанное решение):
- **CKV_YC_2** - "Ensure compute instance does not have public IP"

**Причина:** Публичный IP необходим для доступа к nginx из интернета (задание 1). Добавлен файл `.checkov.yml` для явного пропуска.

## Результаты проверок

### checkov

Passed checks: 8, Failed checks: 0, Skipped checks: 2

Skipped checks:

    CKV_YC_2: Public IP intentionally enabled for nginx access


### terraform validate

Success! The configuration is valid.


### terraform plan

Plan: 8 to add, 0 to change, 0 to destroy.

## Измененные файлы

- ✅ Добавлен модуль `security_group`
- ✅ Обновлен модуль `mysql_cluster` (добавлен `security_group_ids`)
- ✅ Обновлен модуль `vm` (добавлены `security_group_ids`, `core_fraction`, `nginx_port`)
- ✅ Добавлен `backend.tf`
- ✅ Добавлен `versions.tf`
- ✅ Добавлен `.checkov.yml`

## Статус

| Check | Статус | Пояснение |
|-------|--------|-----------|
| CKV_YC_1 | ✅ PASSED | Security group assigned to database |
| CKV_YC_11 | ✅ PASSED | Security groups assigned to network interfaces |
| CKV_YC_19 | ✅ PASSED | No allow-all rules in security groups |
| CKV_YC_4 | ✅ PASSED | No serial console enabled |
| CKV_YC_12 | ✅ PASSED | No public IP for database |
| CKV_YC_2 | ⚠️ SKIPPED | Public IP required for nginx access |

**Итого:** Passed: 8, Failed: 0, Skipped: 2

## Готово к ревью ✅
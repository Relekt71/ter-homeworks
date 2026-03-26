Задание 1

Ошибки:
1 пункт:
В уже выполненном дз
CKV_YC_1:  Отсутствие группы безопасности для кластера базы данных
           Ресурс: yandex_mdb_mysql_cluster
           Проблема: Кластер MySQL не имеет привязанной security group

CKV_YC_11: Отсутствие группы безопасности для сетевого интерфейса ВМ
           Ресурсы: yandex_compute_instance (analytics_vm, marketing_vm)
           Проблема: Сетевые интерфейсы виртуальных машин не защищены security groups

CKV_YC_2:  Публичный IP-адрес у виртуальной машины
           Ресурсы: yandex_compute_instance (analytics_vm, marketing_vm)
           Проблема: ВМ имеют публичные IP-адреса (nat = true)

2 пункт:

CKV_TF_1:  Использование ветки вместо коммита
           Ресурсы: модули test-vm и example-vm
           Проблема: В source указан ?ref=main (ветка), а не конкретный хеш коммита

CKV_TF_2:  Использование ветки вместо тега с версией
           Ресурсы: модули test-vm и example-vm
           Проблема: Отсутствует фиксированная версия (тег), используется ветка main


Задание 2

<img width="1131" height="328" alt="image" src="https://github.com/user-attachments/assets/59789ead-4ab0-43c5-bf51-7b269ea5b2ac" />

Скриншот блокировки стейта

<img width="997" height="90" alt="image" src="https://github.com/user-attachments/assets/ed56dd01-32cb-4935-a4e0-740b57a2d4af" />

Скриншот выполнения команды разблокировки с успешным выполнением

<img width="1066" height="276" alt="image" src="https://github.com/user-attachments/assets/5c5b4c79-6d1f-4cd5-9511-bc756a6905b9" />

Выполнение terraform plan после снятия блокировки

Задание 3

https://github.com/Relekt71/ter-homeworks/pull/2

Тут косякнул и сделал мердж и реверт по неопытности

Задание 4

<img width="857" height="78" alt="image" src="https://github.com/user-attachments/assets/79b1b782-7580-4c30-a095-157c452886bf" />

Валидация правильного ip адреса

<img width="865" height="272" alt="image" src="https://github.com/user-attachments/assets/175d0a98-ff6e-4fee-a7b6-5d102f009b8c" />

Ошибка при передаче неправильного ip адреса

<img width="1024" height="142" alt="image" src="https://github.com/user-attachments/assets/5f4125a0-651a-48f7-b228-7f5f212be2cf" />

Валидация правильных ip адресов из списка

<img width="1024" height="242" alt="image" src="https://github.com/user-attachments/assets/90bf3ff2-2493-424a-8b7d-67b2690fe085" />

Ошибка при наличии хоть 1 неправильного адреса в списке

Задание 5

<img width="476" height="318" alt="image" src="https://github.com/user-attachments/assets/a8da3815-c6ca-4c7d-9697-1403133efa29" />

Проверка, что слова не содержат букв верхнего регистра

<img width="553" height="364" alt="image" src="https://github.com/user-attachments/assets/aeae57f4-41c8-4946-bf79-1c544ff87edb" />

Проверка, что одно из значений true, а второе false






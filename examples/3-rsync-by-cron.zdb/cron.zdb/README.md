# cron

Предназначение: создать запись в cron.d

## Параметры

* **runcmd**=echo alfa-beta-gamma, обязательный параметр

Необязательные параметры:
* minute
* hour
* day
* month
* day_of_week
* user

либо как вариант

* **cronline**=строчка для cron целиком

Подробнее по параметрам см. [интерактивную документацию cron](https://crontab.guru).

## Пример
```
##################### my-cron-5
[cron]
hour=4
minute=15
runcmd=echo hello >/tmp/hello.log
```
Результат: 
* `zapusk apply` создаст файл `/etc/cron.d/zapusk_my-cron-5`, который повлечет выполнение указанной команды ежедневно в 4-15.
* `zapusk destroy` уберет этот файл.
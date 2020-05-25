# Пример 3

Пусть есть запуск-программа следующего содержания:
```
####### do1
[cron]
day_of_week=1,2,3
# понедельник, вторник, среда
runcmd=rsync -avt ssh://myserver.com:/data/files1 /data-backups/myserver.com-files1

####### do2
[cron]
day=4,10,25
# 4-е, 10-е и 25-е число каждого месяца
runcmd=rsync -avt ssh://myserver.com:/data/files2 /data-backups/myserver.com-files2
```

* `zapusk apply` повлечет размещение в cron.d двух записей на запуск приведенных rsync-команд по расписанию.
* `zapusk destroy` уберет созданные ранее записи.

Тип cron в этом примере встроенный, размещен в подкаталоге cron.zdb.
Интересен тем, что в нем используется запуск шелл-скриптов.

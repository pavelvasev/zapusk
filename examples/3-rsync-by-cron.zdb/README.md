# Пример 3

Пусть есть запуск-программа следующего содержания:
```
####### do1
[cron]
# понедельник, вторник, среда в 2-20
hour=2
minute=20
day_of_week=1,2,3
runcmd=rsync -avt ssh://myserver.com:/data/files1 /data-backups/myserver.com-files1

####### do2
[cron]
# 4-е, 10-е и 25-е число каждого месяца в 2-40
hour=2
minute=40
day=4,10,25
runcmd=rsync -avt ssh://myserver.com:/data/files2 /data-backups/myserver.com-files2
```

* `zapusk apply` повлечет размещение в cron.d двух записей на запуск rsync-команд согласно их расписанию.
* `zapusk destroy` уберет созданные записи.

Этот пример использует тип cron, который размещен в подкаталоге cron.zdb.
Он интересен тем, что в нем используется запуск шелл-скриптов.

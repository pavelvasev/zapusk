# Установка нода-приложений

# Параметры

 * **apprepo** репозиторий откуда скачать приложение

# Необязательные параметры
 * **appdir**={{state_dir}}/app -  каталог куда положить
 * **rundir**={{appdir}} - каталог откуда запускать
 * **runcmd**=npm start - команда которую запустить

# Команды
 * apply - скачать, создать init-d скрипт и logrotate-конфиг, запустить
 * destroy - отменить вышесозданные действия
 * restart - перезапустить приложение

# Реализация
Команда проходит по всем блокам, сверху вниз.
* [10-app.ini](10-app.ini) приложение скачивается, и вызывается npm install.
* [20-initd.ini](20-initd.ini) создается init.d скрипт.
* [30-logrotate.ini](30-logrotate.ini) создается logrotate-конфиг.
* [40-auto-start.ini](40-auto-start.ini) программа авто-запускается по команде apply.
# Пример: установка и запуск nodejs-приложений

Пример демонстрирует установку в систему nodejs-приложений.

```
################ app1 ################
[deploy-nodejs-app]
apprepo=https://github.com/johnpapa/node-hello
appdir=/var/my-node-apps/node-hello
runcmd=npm start

################ app2 ################
[deploy-nodejs-app]
apprepo=https://github.com/johnpapa/node-hello
appdir=/var/my-node-apps/node-hello-2
runcmd=PORT=3002 npm start
```

Результат:
* `zapusk apply`- каждое приложение скачивается из git-репозитория, вызывается npm install,
создаются init-d и logrotate-скрипты, и приложение запускается.
* `zapusk destroy` - все приложения останавливаются, скрипты init-d и logrotate удаляются.

Кроме того, благодаря свойствам Zapusk, если в вышеуказанном коде удалить строки про какое-нибудь приложение,
то для него индивидуально автоматически вызовется `zapusk destroy`.

В данном примере создан и используется специальный блок [deploy-nodejs-app.zdb](deploy-nodejs-app.zdb), 
в котором и происходит реализация вышеуказанного функционала (скачивание из репозитория, запуск и т.п.).





#!/bin/bash -e

# - params.sh файл генерируется zapusk-tool-ом в каталоге состояния
#   и в нем размещаются все параметры запуск-программы и их значения
# - текущий каталог для запуска скриптов [os] это каталог состояния
#   поэтому мы можем вызвать source params.sh

source params.sh

if test ! -z "$global_name"
then
  cf="/etc/cron.d/zapusk_$global_name"
  echo "cron file name $cf"
  if test -f "$cf"; then
    rm "$cf"
    echo "removed cron file, ok"
  else
    echo "no cron file found, ok"
  fi
fi

#!/usr/bin/env ruby

=begin
 purpose: generate a /etc/init.d/name script to start/stop the specified command

 name = ARGV[0]   # a system-wide name
 appdir = ARGV[1] # directory to cd into
 runcmd = ARGV[2] # command to run
 
 nuance:
 * all stdout and stderr will be written to /var/log/name.log
 * update-rc is not called
=end

txt = <<EOT
#!/bin/sh
### BEGIN INIT INFO
# Provides:          <NAME>
# Required-Start:    $local_fs $network $named $time $syslog
# Required-Stop:     $local_fs $network $named $time $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Description:       <DESCRIPTION>
### END INIT INFO

SCRIPT="<COMMAND>"
RUNAS=<USERNAME>

PIDFILE=/var/run/<NAME>.pid
#LOGFILE=/var/log/<NAME>.log
#LOGFILE=/chroot.d/log/<NAME>.log
LOGFILE=<LOGFILE>
# mkdir -p /chroot.d/log

start() {
  if [ -f $PIDFILE ] && kill -0 $(cat $PIDFILE) 2>/dev/null; then
    echo 'Service already running' >&2
    return 0
  fi
  echo 'Starting service…' >&2
#вариант 1 чето старое  
# su -c "$SCRIPT >> $LOGFILE 2>&1" $RUNAS & echo $! > $PIDFILE
#вариант 2 ниработает (группа одна и та же получается у разных!) 
# sh -c "$SCRIPT >> $LOGFILE 2>&1 & echo \\$! > $PIDFILE"

  setsid sh -c "$SCRIPT >> $LOGFILE 2>&1 & echo \\$! > $PIDFILE"
  # about setsid: 
  # * https://www.webhostinghero.com/how-to-create-a-process-group-in-linux/
  # * https://stackoverflow.com/questions/30758424/starting-a-new-process-group-from-bash-script
  
# new logic:  
  sleep 0.01
  if [ -f $PIDFILE ] && kill -0 $(cat $PIDFILE); then
    echo 'Service started' >&2
    return 0
  else
    echo 'Service start failure - pid is not visible!' >&2
    return 2
  fi
  
# old logic:
#  echo 'Service started' >&2
}

stop() {
  if [ ! -f "$PIDFILE" ] || ! kill -0 $(cat "$PIDFILE"); then
    echo 'Service not running' >&2
    return 0
  fi
  echo 'Stopping service…' >&2
  # останавливаем по идентификатору группы -- так надо для nodemon и т.д.
  # вызов xargs нужен чтобы убрать пробелы перед номером
  PGID=$(ps --pid $(cat "$PIDFILE") -o pgid= | xargs)
  echo found pgid=$PGID
  kill -9 -$PGID
  sleep 0.29 # почему-то надо поспать если останов по группе
#  kill -9 $(cat "$PIDFILE") && rm -f "$PIDFILE"
  echo 'Service stopped' >&2
}

uninstall() {
  echo -n "Are you really sure you want to uninstall this service? That cannot be undone. [yes|No] "
  local SURE
  read SURE
  if [ "$SURE" = "yes" ]; then
    stop
    rm -f "$PIDFILE"
    echo "Notice: log file is not be removed: '$LOGFILE'" >&2
    update-rc.d -f <NAME> remove
    rm -fv "$0"
  fi
}

case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  uninstall)
    uninstall
    ;;
  restart)
    stop
    start
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|uninstall}"
esac
EOT

name = ARGV[0]
appdir = ARGV[1]
runcmd = ARGV[2]

cmd="cd #{appdir} && #{runcmd}"

txt = txt.gsub("<NAME>",name).gsub("<USERNAME>","root").gsub("<COMMAND>",cmd)
         .gsub("<LOGFILE>",ENV["INITD_LOGFILE"]||"/var/log/#{name}.log")

out="/etc/init.d/#{name}"
puts "writing code to file #{out}"
File.open(out,"w") do |f|
  f.puts txt
end

puts "making file executable"
puts `chmod +x /etc/init.d/#{name}`
#puts "calling update-rc"
#puts `update-rc.d #{name} defaults`

puts "done"

#!/bin/bash
# Adapted from https://gist.github.com/naholyr/4275302
### BEGIN INIT INFO
# Provides:          habitat-helloworld
# Required-Start:    $local_fs $network $named $time $syslog
# Required-Stop:     $local_fs $network $named $time $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Description:       helloworld running in Habitat
### END INIT INFO

SCRIPT="hab start centare/helloworld"
RUNAS="root"

PIDFILE="/var/run/habitat-helloworld.pid"
LOGFILE="/var/log/habitat-helloworld.log"

start() {
  if [ -f /var/run/$PIDNAME ] && kill -0 $(cat /var/run/$PIDNAME); then
    echo 'Service already running' >&2
    return 1
  fi
  echo 'Starting service…' >&2
  local CMD="$SCRIPT &> \"$LOGFILE\" & echo \$!"
  su -c "$CMD" $RUNAS > "$PIDFILE"
  echo 'Service started' >&2
}

stop() {
  if [ ! -f "$PIDFILE" ] || ! kill -0 $(cat "$PIDFILE"); then
    echo 'Service not running' >&2
    return 1
  fi
  echo 'Stopping service…' >&2
  kill -15 $(cat "$PIDFILE") && rm -f "$PIDFILE"
  echo 'Service stopped' >&2
}

status() {
  if [ ! -f "$PIDFILE" ] || ! $(ps -e | grep $(cat "$PIDFILE")); then
    echo 'Service not running' >&2
    return 1
  fi
  return 0
}

case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  status)
    status
    ;;
  retart)
    stop
    start
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|status}"
esac

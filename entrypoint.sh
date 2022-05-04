#!/bin/bash

/usr/local/bin/prometheus_wireguard_exporter -n /etc/wireguard/wg0.conf &
  
exec "$@" &
 
wait -n

exit $?

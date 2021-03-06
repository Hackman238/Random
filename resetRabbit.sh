#!/bin/bash

set -e

VHOSTS="/zenoss"
USER="zenoss"
PASS="zenoss"
RABBITMQCTL="rabbitmqctl"
if [ `uname -s` = "Linux" ]; then
	RABBITMQCTL="/usr/sbin/$RABBITMQCTL"
    if [ `id -u` -ne 0 ]; then
        RABBITMQCTL="sudo $RABBITMQCTL"
    fi
fi

$RABBITMQCTL stop_app
$RABBITMQCTL reset
$RABBITMQCTL start_app
$RABBITMQCTL add_user "$USER" "$PASS"
for vhost in $VHOSTS; do
    $RABBITMQCTL add_vhost "$vhost"
    $RABBITMQCTL set_permissions -p "$vhost" "$USER" '.*' '.*' '.*'
done

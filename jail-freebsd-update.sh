#!/bin/sh
# usage: sh jail-freebsd-update.sh myjailname

# test if arguments exists
if [ -z "$1" ]; then
        echo "no arguments provided - jail name"
        exit 1
fi

JAIL_NAME=$1

# test if jail exists
LIST=`jls name | grep '^'"$JAIL_NAME"'$' | wc -l`
if [ "$LIST" -eq "0" ]; then
        echo "jail: $JAIL_NAME not exists"
        exit 1
fi

# check if update is needed
# freebsd-version -u of host must be diffrent than jail 
HOST_VERSION=$(freebsd-version -u)
JAIL_VERSION=$(jexec $JAIL_NAME freebsd-version -u)

if [ $HOST_VERSION = $JAIL_VERSION ]
then
	echo "Jail '$JAIL_NAME' do not need update"
	exit 1
fi

JAIL_PATH=$(jls -j $JAIL_NAME path)

# test if path exists
if [ ! -d "$JAIL_PATH" ]; then
	echo "path: $JAIL_PATH not exists"
        exit 1
fi

# update
env PAGER=cat freebsd-update --not-running-from-cron --currently-running $JAIL_VERSION -f /etc/freebsd-update-jail.conf -b $JAIL_PATH fetch
env PAGER=cat freebsd-update --not-running-from-cron --currently-running $JAIL_VERSION -f /etc/freebsd-update-jail.conf -b $JAIL_PATH install
service jail restart $JAIL_NAME

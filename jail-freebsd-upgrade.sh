#!/bin/sh
# 20200723
# usage: sh jail-freebsd-upgrade.sh myjailname 11.4-RELEASE

# test if arguments exists
if [ -z "$1" ]; then
        echo "no arguments provided - jail name"
        exit 1
fi

if [ -z "$2" ]; then
        echo "no arguments provided - target release vesrsion"
        exit 1
fi

JAIL_NAME=$1
JAIL_TARGET_RELEASE=$2

# test if jail exists
LIST=`jls name | grep "$JAIL_NAME" | wc -l`
if [ "$LIST" -eq "0" ]; then
        echo "jail: $JAIL_NAME not exists"
        exit 1
fi

JAIL_PATH=$(jls -j $JAIL_NAME path)

# test if path exists
if [ ! -d "$JAIL_PATH" ]; then
	echo "path: $JAIL_PATH not exists"
        exit 1
fi

# check if uppgrade is needed
# freebsd-version -u of host must be diffrent than jail 
HOST_VERSION=$(freebsd-version -u)
JAIL_VERSION=$(jexec $JAIL_NAME freebsd-version -u)

if [ $HOST_VERSION = $JAIL_VERSION ]
then
	echo "Jail '$JAIL_NAME' do not need upgrade"
	exit 1
fi

freebsd-update --not-running-from-cron -b $JAIL_PATH -f /etc/freebsd-update-jail.conf --currently-running $JAIL_VERSION -r $JAIL_TARGET_RELEASE upgrade
freebsd-update --not-running-from-cron -b $JAIL_PATH install
service jail restart $JAIL_NAME
freebsd-update --not-running-from-cron -b $JAIL_PATH install

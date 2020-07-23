#!/bin/sh
for jail in $(jls name); do
	sh jail-freebsd-update.sh $jail
done


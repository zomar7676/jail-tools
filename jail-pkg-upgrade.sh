#!/bin/sh
for jail in $(jls name); do
	date=$(date)
	str="$date - Upgrade: $jail"
	echo $str
	echo $str >> /var/log/jail-pkg-upgrade.log
	pkg -j $jail update >> /var/log/jail-pkg-upgrade.log
	pkg -j $jail upgrade -y >> /var/log/jail-pkg-upgrade.log 
	service jail restart $jail >> /var/log/jail-pkg-upgrade.log
	pkg -j $jail autoremove -y >> /var/log/jail-pkg-upgrade.log
	pkg -j $jail clean -ay >> /var/log/jail-pkg-upgrade.log
done

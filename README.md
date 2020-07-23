# zomar7676/jail-tools

## jail-freebsd-version.sh
quick view on all jail

usage:
./jail-freebsd-version.sh

Example output:
```
hostname                  jail name  freebsd-version -u  freebsd-version -k  freebsd-version -r
j00.example.com           -          11.4-RELEASE-p1     11.4-RELEASE-p1     11.4-RELEASE-p1
default.j00.example.com   default    11.4-RELEASE-p1
unbound.j00.example.com   unbound    11.4-RELEASE-p1
update.j00.example.com    update     11.4-RELEASE-p1
dev01.j00.example.com     dev01      11.4-RELEASE-p1
dev02.j00.example.com     dev02      11.4-RELEASE-p1
```

## jail-freebsd-update.sh

params:
- jail name

usage:
./jail-freebsd-update.sh myjailname

## jail-freebsd-update-all.sh
update all jails found in jls, base on jail-freebsd-update.sh

usage:
./jail-freebsd-update-all.sh 

## jail-freebsd-upgrade.sh

params:
- jail name
- target release

usage:
./jail-freebsd-upgrade.sh myjailname 11.4-RELEASE

## jail-pkg-upgrade.sh
brutal update/upgrade pkg on all jails found in jls

usage:
./jail-freebsd-upgrade.sh



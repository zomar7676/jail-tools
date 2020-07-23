#!/bin/sh
tempfoo=`basename $0`
TMPFILE=`mktemp -q /tmp/${tempfoo}.XXXXXX`
if [ $? -ne 0 ]; then
        echo "$0: Can't create temp file, exiting..."
        exit 1
fi

echo "hostname|jail name|freebsd-version -u|freebsd-version -k|freebsd-version -r" >> $TMPFILE

s1=$(hostname)
s2="-"
s3=$(freebsd-version -u)
s4=$(freebsd-version -k)
s5=$(freebsd-version -r)

echo "$s1|$s2|$s3|$s4|$s5" >> $TMPFILE

for jail in $(jls name); do
        s1=$(jexec $jail hostname)
        s2=$jail
        s3=$(jexec $jail freebsd-version -u)
        echo "$s1|$s2|$s3" >> $TMPFILE
done

column -t -s "|" $TMPFILE

rm $TMPFILE

exit 0

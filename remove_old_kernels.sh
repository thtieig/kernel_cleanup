#!/bin/bash

CURRENTVERSION=$(uname -r)
TRASH=/tmp/oldkernelsleftover

echo "The current version of your kernel is $CURVER. This script will remove all the other ones installed.
REVIEW the below output before proceeding"

mkdir -p $TRASH


apt-get purge $(dpkg-query -l "linux*" | grep "ii" | egrep "linux-headers|linux-image|linux-signed-image" | grep -v $(echo $CURRENTVERSION | sed 's/-generic//' | sed 's/-/./') | awk '{print $2}')

cd /lib/modules/
for dir in $(ls | grep -v $CURRENTVERSION) ; do
  mv $dir $TRASH/
done

echo "All done. Check $TRASH if there is anything that you want to keep or simply delete the folder.
This comes from /lib/modules."



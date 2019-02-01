#!/bin/bash

remoteCon=$(echo "$1" | cut -d: -f1)
remoteDir=$(echo "$1" | cut -d: -f2)

localOutFile="${2}.tar.bz"

echo "Backing up: $remoteDir on remote: $remoteCon to local file: $localOutFile"

ssh $remoteCon "cd \"$(dirname $remoteDir)\"; tar cjvf - \"$(basename $remoteDir)\" |aespipe -e AES256 -P /root/keys.txt" | cat > $localOutFile



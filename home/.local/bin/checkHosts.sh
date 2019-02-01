#! /bin/bash

rm good no_auth other
while read ip ; do
    echo "ip: ${ip} | host: ${host}"
    status="$(checkHost.sh $ip)"
    echo $status
    if [[ $status == ok ]] ; then
        echo $ip $host >> good
    elif [[ $status == "Permission denied"* ]] ; then
        echo $ip $host $status >> no_auth
    else
        echo $ip $host $status >> other
    fi
done < $1



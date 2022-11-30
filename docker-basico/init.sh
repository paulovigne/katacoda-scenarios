#!/bin/bash

echo -n "Verificando o estado o Docker..."

result=1
while [ $result -ne 0 ]
    do
        sleep 10
        docker info
        if [ $? -eq 0 ]
            then
                result=0
            fi
    done

#docker images -a | awk '{print $3}' | grep -v IMAGE | xargs docker rmi -f
apt -y install net-tools jq

echo "Tudo pronto!"
sleep 1
clear







#!/bin/bash

echo -n "Verificando o estado do Cluster..."

while [ $(kubectl get node 2>/dev/null | grep Ready | wc -l) -ne 2 ]
    do
        sleep 1
        echo -n "."
    done

echo

echo "Tudo pronto!"
sleep 1
clear

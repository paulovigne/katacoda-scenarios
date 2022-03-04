#!/bin/bash

echo -n "Verificando o estado do Cluster..."

while [ $(kubectl get node 2>/dev/null | grep Ready | wc -l) -ne 2 ]
    do
        sleep 1
        echo -n "."
    done

echo
echo "Verificando o Deploy do Ingress Controller"

kubectl apply -f ./manifestos/install-ingress.yaml

result=1
while [ $result -ne 0 ]
    do
        sleep 10
        kubectl get ns ingress-nginx
        if [ $? -eq 0 ]
            then
                result=0
            fi
    done

kubectl -n ingress-nginx rollout status deployment ingress-nginx-controller

echo "Tudo pronto!"
sleep 1
clear

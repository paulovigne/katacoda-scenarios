echo "Aguardando o Deploy do Cluster"

result=1
while [ $result -ne 0 ]
    do
        kubectl get ns ingress-nginx
        if [ $? -eq 0 ]
            then
                result="0"
            fi
    done

kubectl -n ingress-nginx rollout status deployment ingress-nginx-controller

echo "Tudo pronto!"

clear
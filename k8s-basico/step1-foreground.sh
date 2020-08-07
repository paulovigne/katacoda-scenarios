echo "Aguardando o Deploy do Cluster"

kubectl -n ingress-nginx rollout status deployment ingress-nginx-controller

echo "Tudo pronto!"

clear

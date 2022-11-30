
### Criando um Ingress

```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  labels:
    app: webserver
  name: webserver
spec:
  rules:
  - host: ${INGRESS_HOST}
    http:
      paths:
      - backend:
          service:
            name: webserver
            port:
              number: 8080
        path: /
        pathType: Prefix
```

##### Obtendo o Nome do Balanceador do Katacoda:
`KILLERCODA_LB=$(echo {{TRAFFIC_HOST2_80}} | cut -d/ -f3);KILLERCODA_LB_ID=$(echo $KILLERCODA_LB | cut -d. -f1);KILLERCODA_LB_SUFIX=$(echo $KILLERCODA_LB | cut -d. -f2-10);export INGRESS_HOST=$KILLERCODA_LB_ID.webserver.$KILLERCODA_LB_SUFIX
`{{execute}}

##### Substituindo o Balanceador no Manifesto:
`envsubst < ./manifestos/webserver-ingress.yaml | kubectl apply -f -`{{execute}}

##### Veja no Navegador:
`echo Digite o Seguinte endereço no Browser: https://${NGRESS_HOST}`{{execute}}

#### Verificando o Ingress:

`kubectl get ingress`{{execute}}

`kubectl describe ingress webserver`{{execute}}

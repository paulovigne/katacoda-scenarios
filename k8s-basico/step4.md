
### Criando um Ingress

```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  labels:
    app: webserver
  name: webserver
spec:
  rules:
  - host: webserver.${KATACODA_LB}
    http:
      paths:
      - backend:
          serviceName: webserver
          servicePort: 8080
        path: /
```

#### Obtendo o Nome do Balanceador do Katacoda:
`export KATACODA_LB=[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

#### Substituindo o Balanceador no Manifesto:
`envsubst < ./manifestos/webserver-ingress.yaml | kubectl apply -f -`{{execute}}

[Acesso ao Site por Ingress](https://webserver.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/)

### Verificando o Service:

`kubectl get ingress`{{execute}}

`kubectl describe ingress webserver`{{execute}}

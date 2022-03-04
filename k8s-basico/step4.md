
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
  - host: webserver.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com
    http:
      paths:
      - backend:
          serviceName: webserver
          servicePort: 8080
        path: /
```

`export HOST_ING=webserver.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

`envsubst < ./manifestos/webserver-ingress.yaml | kubectl apply -f -`{{execute}}

[Acesso ao Site por Ingress](https://webserver.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/)

### Verificando o Service:

`kubectl get ingress`{{execute}}

`kubectl describe ingress webserver`{{execute}}

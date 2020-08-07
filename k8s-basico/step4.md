
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
  - http:
      paths:
      - backend:
          serviceName: webserver
          servicePort: 8080
        path: /
```

`kubectl apply -f ./manifestos/webserver-ingress.yaml`{{execute}}

[Acesso ao Site por Ingress](https://[[HOST_SUBDOMAIN]]-30080-[[KATACODA_HOST]].environments.katacoda.com/)

### Verificando o Service:

`kubectl get ingress`{{execute}}

`kubectl describe ingress webserver`{{execute}}


### Criando um Ingress

```
apiVersion: v1
data:
  index.html: |
    <hr /><table style="margin-left: auto; margin-right: auto;">
    <tbody><tr>
    <td style="text-align: center;">DEAT - TESTE</td>
    </tr><tr><td>
    <h1><span style="color: #3366ff;"><strong>Teste do K8S Lab</strong></span></h1>
    </td></tr><tr>
    <td style="text-align: center;">&nbsp;Ingress - OK</td>
    </tr>
    </tbody></table><hr />
kind: ConfigMap
metadata:
  name: welcome
  labels:
    app: webserver
```

`kubectl apply -f ./manifestos/webserver-configmap.yaml`{{execute}}

### Modificando o Deployment

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webserver
  labels:
    app: nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: webserver
  template:
    metadata:
      labels:
        app: webserver
    spec:
      containers:
      - name: nginx
        image: bitnami/nginx:1.18
        ports:
        - containerPort: 8080
        volumeMounts:
        - mountPath: /app/index.html
          name: welcome
          subPath: index.html
      volumes:
      - configMap:
          defaultMode: 420
          name: welcome
          optional: false
        name: welcome
```
`kubectl apply -f ./manifestos/webserver-deployment-cm.yaml`{{execute}}

Ingress: https://[[HOST_SUBDOMAIN]]-30080-[[KATACODA_HOST]].environments.katacoda.com/

### Acessando o POD:

`kubectl get pods`{{execute}}

`kubectl exec -it <nomedopod> -- bash`{{copy}}

### Verificando os Logs

`kubectl logs <nomedopod> --tail=10 -f`{{copy}}
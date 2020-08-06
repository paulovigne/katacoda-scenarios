#
### Realizando um Deployment

`apiVersion: apps/v1
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
        - containerPort: 8080`{{copy}}

`kubectl apply -f ./manifestos/webserver-deployment.yaml`{{execute}}

### Verificando o Deployment:

`kubectl rollout status deployment webserver`{{execute}}

`kubectl get deployments`{{execute}}

`kubectl get replicasets`{{execute}}

`kubectl get pods`{{execute}}

### Obtendo os Namespaces:

`kubectl scale deployment webserver --replicas=3`{{execute}}

* Repita os comandos para obter os Pods e os ReplicaSets

### Apagando um Deployment

`kubectl delete pods <nomedopod>`{{copy}}

`kubectl delete pods --all`{{execute}}

`kubectl delete deployment webserver`{{execute}}

* Recrie o Deployment
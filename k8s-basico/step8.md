
### Realizando um Deployment WordPress

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: wordpress
  namespace: wordpress
  labels:
    app: wordpress
spec:
  selector:
    matchLabels:
      app: wordpress
      tier: frontend
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        app: wordpress
        tier: frontend
    spec:
      containers:
      - image: wordpress:5.4-php7.2-apache
        name: wordpress
        env:
        - name: WORDPRESS_DB_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-pass
              key: password
        - name: WORDPRESS_DB_USER
          valueFrom:
            configMapKeyRef:
              name: mysql-param
              key: username
        - name: WORDPRESS_DB_NAME
          valueFrom:
            configMapKeyRef:
              name: mysql-param
              key: database
        - name: WORDPRESS_DB_HOST
          valueFrom:
            configMapKeyRef:
              name: mysql-param
              key: hostname
        ports:
        - containerPort: 80
          name: wordpress
```

`kubectl apply -f ./manifestos/wordpress-deployment.yaml`{{execute}}

### Verificando o Deployment:

`kubectl -n wordpress get pods -l tier=frontend`{{execute}}

### Criando Service ClusterIP:

```
apiVersion: v1
kind: Service
metadata:
  name: wordpress
  namespace: wordpress
  labels:
    app: wordpress
spec:
  ports:
  - name: http
    port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: wordpress
    tier: frontend
  type: ClusterIP
```

`kubectl apply -f ./manifestos/wordpress-service.yaml`{{execute}}

### Verificando o Serviço

`kubectl -n wordpress get svc`{{execute}}

### Criando o Ingress

```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  labels:
    app: wordpress
  name: wordpress
  namespace: wordpress
spec:
  rules:
  - http:
      paths:
      - backend:
          serviceName: wordpress
          servicePort: 80
        path: /
```

`kubectl apply -f ./manifestos/wordpress-ingress.yaml`{{execute}}

### Testando

[Acesso ao Site por Ingress](https://[[HOST_SUBDOMAIN]]-30080-[[KATACODA_HOST]].environments.katacoda.com/)

* Como não temos DNS customizável, nosso ingress sempre aponta para "all hosts" ( * ), ou seja, o ingress do exercício anterior está sobrepondo o atual, para concluir este exercício, remova o ingress webserver do namespace default.

`kubectl delete ingress webserver -n default`{{execute}}

* Teste novamente o acesso e verifique se o WordPress irá abrir.
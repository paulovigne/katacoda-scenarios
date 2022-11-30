
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
##### Fazendo o Deploy do POD WordPress, repare os ConfigMaps e Secrets como variaveis de ambiente

`kubectl apply -f ./manifestos/wordpress-deployment.yaml`{{execute}}

##### Verificando o Deployment:

`kubectl -n wordpress get pods -l tier=frontend`{{execute}}

##### Criando Service ClusterIP:

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

##### Verificando o Serviço

`kubectl -n wordpress get svc`{{execute}}

##### Criando o Ingress

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
  - host: wordpress.${KATACODA_LB}
    http:
      paths:
      - backend:
          serviceName: wordpress
          servicePort: 80
        path: /
```

##### Obtendo o Nome do Balanceador do Katacoda:
`export KATACODA_LB={{TRAFFIC_HOST2_80}}`{{execute}}

##### Substituindo o Balanceador no Manifesto:
`envsubst < ./manifestos/wordpress-ingress.yaml | kubectl apply -f -`{{execute}}

##### Repare que agora existem dois ingresses no mesmo balanceador:
`kubectl get ingress -A`{{execute}}

##### Testando

[Acesso ao Site por Ingress](https://wordpress.{{TRAFFIC_HOST2_80}})

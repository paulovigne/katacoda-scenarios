
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
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  labels:
    app: wordpress
  name: wordpress
  namespace: wordpress
spec:
  rules:
  - host: ${INGRESS_HOST}
    http:
      paths:
      - backend:
          service:
            name: wordpress
            port:
              number: 80
        path: /
        pathType: Prefix
```


##### Obtendo o Nome do Balanceador do Katacoda:
`KILLERCODA_LB=$(echo {{TRAFFIC_HOST2_80}} | cut -d/ -f3);KILLERCODA_LB_ID=$(echo $KILLERCODA_LB | cut -d. -f1);KILLERCODA_LB_SUFIX=$(echo $KILLERCODA_LB | cut -d. -f2-10);export INGRESS_HOST=$KILLERCODA_LB_ID.wordpress.$KILLERCODA_LB_SUFIX
`{{execute}}

##### Substituindo o Balanceador no Manifesto:
`envsubst < ./manifestos/wordpress-ingress.yaml | kubectl apply -f -`{{execute}}

##### Repare que agora existem dois ingresses no mesmo balanceador:
`kubectl get ingress -A`{{execute}}

##### Testando

##### Veja no Navegador:
`echo Digite o Seguinte endereço no Browser: https://${INGRESS_HOST}`{{execute}}

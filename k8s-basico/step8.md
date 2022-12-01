
### Realizando o Deployment do Drupal

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: drupal
  namespace: drupal
  labels:
    app: drupal
spec:
  selector:
    matchLabels:
      app: drupal
      tier: frontend
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        app: drupal
        tier: frontend
    spec:
      containers:
      - image: drupal:9.4.8-apache
        name: drupal
        ports:
        - containerPort: 80
          name: drupal
```
##### Fazendo o Deploy do POD drupal, repare os ConfigMaps e Secrets como variaveis de ambiente

`kubectl apply -f ./manifestos/drupal-deployment.yaml`{{execute}}

##### Verificando o Deployment:

`kubectl -n drupal get pods -l tier=frontend`{{execute}}

##### Criando Service ClusterIP:

```
apiVersion: v1
kind: Service
metadata:
  name: drupal
  namespace: drupal
  labels:
    app: drupal
spec:
  ports:
  - name: http
    port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: drupal
    tier: frontend
  type: ClusterIP
```

`kubectl apply -f ./manifestos/drupal-service.yaml`{{execute}}

##### Verificando o Serviço

`kubectl -n drupal get svc`{{execute}}

##### Criando o Ingress

```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  labels:
    app: drupal
  name: drupal
  namespace: drupal
spec:
  rules:
  - host: ${INGRESS_HOST}
    http:
      paths:
      - backend:
          service:
            name: drupal
            port:
              number: 80
        path: /
        pathType: Prefix
```


##### Obtendo o Nome do Balanceador do Katacoda:
`KILLERCODA_LB=$(echo {{TRAFFIC_HOST2_80}} | cut -d/ -f3);KILLERCODA_LB_ID=$(echo $KILLERCODA_LB | cut -d. -f1);KILLERCODA_LB_SUFIX=$(echo $KILLERCODA_LB | cut -d. -f2-10);export INGRESS_HOST=$KILLERCODA_LB_ID.drupal.$KILLERCODA_LB_SUFIX
`{{execute}}

##### Substituindo o Balanceador no Manifesto:
`envsubst < ./manifestos/drupal-ingress.yaml | kubectl apply -f -`{{execute}}

##### Repare que agora existem dois ingresses no mesmo balanceador:
`kubectl get ingress -A`{{execute}}

##### Testando

##### Veja no Navegador:
`echo Digite o Seguinte endereço no Browser: https://${INGRESS_HOST}`{{execute}}

##### Configurando o Drupal:
Após a abertura no Browser jogue os parâmetros previamente configurados para o Banco:
* ***Usuário:*** `drupal_user`
* ***Senha:*** `PassWord00`
* ***Banco de Dados:*** `drupal`
* ***Servidor de Banco:*** `drupal-mysql`

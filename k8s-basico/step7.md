
### Realizando um Deployment de um StatefulSet

```
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: drupal-mysql
  namespace: drupal
  labels:
    app: drupal
spec:
  selector:
    matchLabels:
      app: drupal
      tier: mysql
  serviceName: "drupal-mysql"
  template:
    metadata:
      labels:
        app: drupal
        tier: db
    spec:
      containers:
      - image: mysql:5.7
        name: mysql
        env:
        - name: MYSQL_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-pass
              key: password
        - name: MYSQL_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-pass
              key: password
        - name: MYSQL_USER
          valueFrom:
            configMapKeyRef:
              name: mysql-param
              key: username
        - name: MYSQL_DATABASE
          valueFrom:
            configMapKeyRef:
              name: mysql-param
              key: database
        ports:
        - containerPort: 3306
          name: mysql
```

#### Aplicando o Statefulset, repare no uso das secrets como variáveis em env/secretKeyRef

`kubectl apply -f ./manifestos/drupal-mysql-statefulset.yaml`{{execute}}

##### Verificando o Deployment:

`kubectl -n drupal rollout status statefulset drupal-mysql`{{execute}}

`kubectl -n drupal get statefulsets`{{execute}}

`kubectl -n drupal describe statefulset drupal-mysql`{{execute}}

`kubectl -n drupal get pods -l tier=db`{{execute}}

##### Verificando os logs do MySQL:

`kubectl -n drupal logs drupal-mysql-0 --tail=10 -f`{{execute}}

* Digite Ctrl + C para sair, pois estamos com o -f habilitado (follow).

##### Acessando o POD do MySQL:

`kubectl -n drupal exec -it drupal-mysql-0 -- bash`{{execute}}

* Para acessar o console do MySQL digite: `mysql -u root -pPassWord00`{{execute}}
* Liste os Bancos: `show databases;`{{execute}}
* Acesso um Banco: `use drupal;`{{execute}}
* Liste as Tabelas: `show tables;`{{execute}}
* Para Sair: `quit`{{execute}}
* Estamos dentro do pod para sair digite `exit`{{execute}}

##### Criando um Headless Service:

```
apiVersion: v1
kind: Service
metadata:
  name: drupal-mysql
  namespace: drupal
  labels:
    app: drupal
spec:
  ports:
    - port: 3306
  selector:
    app: drupal
    tier: db
  clusterIP: None
```

`kubectl apply -f ./manifestos/drupal-service-mysql.yaml`{{execute}}

##### Verificando o Serviço

`kubectl -n drupal get svc`{{execute}}

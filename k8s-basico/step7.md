
### Realizando um Deployment de um StatefulSet

```
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: wordpress-mysql
  namespace: wordpress
  labels:
    app: wordpress
spec:
  selector:
    matchLabels:
      app: wordpress
      tier: mysql
  serviceName: "wordpress-mysql"
  template:
    metadata:
      labels:
        app: wordpress
        tier: db
    spec:
      containers:
      - image: mysql:5.6
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

`kubectl apply -f ./manifestos/wordpress-statefulset.yaml`{{execute}}

##### Verificando o Deployment:

`kubectl -n wordpress rollout status statefulset wordpress-mysql`{{execute}}

`kubectl -n wordpress get statefulsets`{{execute}}

`kubectl -n wordpress describe statefulset wordpress-mysql`{{execute}}

`kubectl -n wordpress get pods -l tier=db`{{execute}}

##### Verificando os logs do MySQL:

`kubectl -n wordpress logs wordpress-mysql-0 --tail=10 -f`{{execute}}

* Digite Ctrl + C para sair, pois estamos com o -f habilitado (follow).

##### Acessando o POD do MySQL:

`kubectl -n wordpress exec -it wordpress-mysql-0 -- bash`{{execute}}

* Para acessar o console do MySQL digite: `mysql -u root -pPassWord00`{{execute}}
* Liste os Bancos: `show databases;`{{execute}}
* Acesso um Banco: `use wordpress;`{{execute}}
* Liste as Tabelas: `show tables;`{{execute}}
* Para Sair: `quit`{{execute}}
* Estamos dentro do pod para sair digite `exit`{{execute}}

##### Criando um Headless Service:

```
apiVersion: v1
kind: Service
metadata:
  name: wordpress-mysql
  namespace: wordpress
  labels:
    app: wordpress
spec:
  ports:
    - port: 3306
  selector:
    app: wordpress
    tier: db
  clusterIP: None
```

`kubectl apply -f ./manifestos/wordpress-service-mysql.yaml`{{execute}}

##### Verificando o Serviço

`kubectl -n wordpress get svc`{{execute}}

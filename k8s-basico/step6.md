
### Criando Secrets

Vamos criar uma Secret para ser utilizada como variável de ambiente.

Primeiro vamos criar um novo NameSpace:

`kubectl create namespace drupal`{{execute}}

Vamos agora criar a Secret, toda secret mantem os dados em Base64

`echo -n "PassWord00" | base64`{{execute}}

```
apiVersion: v1
kind: Secret
metadata:
  name: mysql-pass
  namespace: drupal
  labels:
    app: drupal
type: Opaque
data:
  password: UGFzc1dvcmQwMA==
```

`kubectl apply -f ./manifestos/mysql-secret.yaml`{{execute}}

##### Verificando a Secret

`kubectl -n drupal get secrets`{{execute}}

`kubectl -n drupal describe secret mysql-pass`{{execute}}

##### ConfigMap como variável de ambiente

```
apiVersion: v1
data:
  hostname: drupal-mysql
  username: drupal_user
  database: drupal
kind: ConfigMap
metadata:
  name: mysql-param
  namespace: drupal
  labels:
    app: drupal
```

`kubectl apply -f ./manifestos/mysql-configmap.yaml`{{execute}}

##### Verificando o ConfigMap

`kubectl -n drupal get cm`{{execute}}

`kubectl -n drupal describe cm mysql-param`{{execute}}

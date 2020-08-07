
### Criando Secrets

Vamos criar uma Secret para ser utilizada como variável de ambiente.

Primeiro vamos criar um novo NameSpace:

`kubectl create namespace wordpress`{{execute}}

Vamos agora criar a Secret, toda secret mantem os dados em Base64

`echo -n "PassWord00" | base64`{{execute}}

```
apiVersion: v1
kind: Secret
metadata:
  name: mysql-pass
  namespace: wordpress
  labels:
    app: wordpress
type: Opaque
data:
  password: UGFzc1dvcmQwMA==
```

`kubectl apply -f ./manifestos/wordpress-secret.yaml`{{execute}}

### Verificando a Secret

`kubectl -n wordpress get secrets`{{execute}}

`kubectl -n wordpress describe secret mysql-pass`{{execute}}

### ConfigMap como variável de ambiente

```
apiVersion: v1
data:
  hostname: wordpress-mysql
  username: wordpress_user 
kind: ConfigMap
metadata:
  name: mysql-param
  namespace: wordpress
  labels:
    app: wordpress
```
`kubectl apply -f ./manifestos/wordpress-configmap.yaml`{{execute}}

### Verificando o ConfigMap

`kubectl -n wordpress get cm`{{execute}}

`kubectl -n wordpress describe cm mysql-param`{{execute}}
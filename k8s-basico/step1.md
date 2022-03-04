
##### Obtendo a Versão do Cluster

`kubectl version`{{execute}}

`kubectl cluster-info`{{execute}}

##### Obtendo os Nodes:

`kubectl get nodes`{{execute}}

`kubectl get nodes -o wide`{{execute}}

`kubectl get nodes --show-labels`{{execute}}

##### Obtendo os Namespaces:

`kubectl get namespaces`{{execute}}

##### Obtendo mais detalhes do Namespace "default":

`kubectl describe ns default`{{execute}}

##### Obtendo os Pods do Namespace "kube-system":

`kubectl get pods -n kube-system`{{execute}}

##### Obtendo todos os Pods de todos Namespaces:

`kubectl get pods -A`{{execute}}

##### Obtendo os Pods do Namespace "default" ou default context:

`kubectl get pods`{{execute}}

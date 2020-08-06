
### Obtendo a Versão do Cluster

`kubectl version`{{execute}}

`kubectl cluster-info`{{execute}}

### Obtendo os Nodes:

`kubectl get nodes`{{execute}}

`kubectl get nodes -o wide`{{execute}}

`kubectl get nodes --show-labels`{{execute}}

### Obtendo os Namespaces:

`kubectl get namespaces`{{execute}}

`kubectl describe ns default`{{execute}}

### Obtendo os Pods:

`kubectl get pods -n kube-system`{{execute}}

`kubectl get pods -A`{{execute}}

`kubectl get pods`{{execute}}
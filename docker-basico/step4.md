
##### Extraindo o Log de um container
`docker logs nginx --tail 10 -f`{{execute}}

##### Entrando em um container em execução
`docker exec -it nginx bash`{{execute}}

### Inspecionando a rede

##### Observer a interface de bridge criada pelo docker:

`docker network ls`{{execute}}

##### No Json podemos ver os endereços IPs de overlay da rede interna do docker para cada container:

`docker network inspect bridge | jq`{{execute}}

##### No sistema operacional: 

`ip a`{{execute}}

##### Vamos parar novamente o container:

`docker stop nginx`{{execute}}

Repare que desta vez com o parâmetro "--rm", ao dar stop, o docker automaticamente removeu o container.

`docker ps -a`{{execute}}
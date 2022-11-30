
##### Baixando uma imagem
Imagem do [ubuntu](https://hub.docker.com/_/ubuntu):

`docker pull ubuntu`{{execute}}

`docker run ubuntu`{{execute}}

##### Porque não prendeu o shell?
Ao observar o [Dockerfile](https://github.com/tianon/docker-brew-ubuntu-core/blob/f2f3f01ed67bab2e24b8c4fda60ef035a871b4c7/focal/Dockerfile) do Ubuntu, percebemos que só existe um CMD executando o "bash", ou seja não é um Daemon, podemos então prender este shell, alocando um TTY a ele:

`docker run -i -t ubuntu`{{execute}}

Parâmetro  | Descrição
---------- | -----------
-i | Mantem o STDIN
-t | Aloca um pseudo TTY

Ao executar o comando, somos transferidos para dentro do shell do container, e estamos isolados do sistema operacional hospedeiros, e ao sair, o container entra em estado de stop. para sair digite `exit`{{execute}} e de enter.

Para ver o container em estado de stop é necessário adicionar o parâmetro "-a":

`docker ps -a`{{execute}}

Aproveite para observar um nome bem criativo gerado automaticamente na última coluna para o container.

###### Outros parâmentos do docker run:

Parâmetro  | Descrição
---------- | -----------
--rm | Remove o container quando sai
--restart | Política de restart: always / on-failure:n / unless-stopped
--name | Personaliza o nome para o container em execução
-d | Roda como daemon em background
-p | Publica a porta do container

##### Rodando o Nginx como Daemon

Devemos observar o seguinte, para saber em que porta o container roda, devemos sempre consultar a [documentacao da imagem](https://hub.docker.com/_/nginx), logo perceberemos que ela roda na porta 80, sendo assim vamos mapear a imagem para rodar na porta 8080 do host com o parâmetro "-p" e o "-d" para rodar em background:

`docker run --name nginx -d -p 8080:80 nginx`{{execute}}

##### Vamos observar no Sistema operacional o que aconteceu:
 `netstat -tupan | grep LISTEN`{{execute}}

##### Testando a aplicação

`curl 127.0.0.1:8080`{{execute}}

ou pelo link do [host]({{TRAFFIC_HOST1_8080}})

##### Vamos parar o container:

`docker stop nginx`{{execute}}

##### Agora tente rodar novamente:

`docker run --name nginx -d -p 8080:80 nginx`{{execute}}

Repare que agora recebemos uma mensagem de conflito pois o container com o nome "nginx" já existe. Desta vez como nomeamos não podemos sobrepor, antes eram nomes aleatórios gerados pelo docker.

##### Para ver o container em stop rode:

`docker ps -a`{{execute}}

##### Para remover rode:

`docker rm nginx`{{execute}}

Caso deseje apenas iniciar novamente o container, execute `docker start nginx`{{copy}}

##### Mudando a porta

`docker run --rm --name nginx -d -p 80:80 nginx`{{execute}}

##### Testando a aplicação na nova porta

`curl 127.0.0.1:80`{{execute}}

ou pelo link do [host]({{TRAFFIC_HOST1_80}})


#### Passando variáveis para o container
Vamos criar dois containers com a imagem de teste "simple-webapp-color" observe no comando o parâmetro "-e APP_COLOR=", respectivamente irão rodar dois containers rosa e azul nas portas 8080 e 8081 para não ocorrer conflito de portas no hospedeiro:

`docker run --rm --name fundo_rosa -e APP_COLOR=pink -d -p 8080:8080 mmumshad/simple-webapp-color`{{execute}}

Veja a app [fundo_rosa]({{TRAFFIC_HOST1_8080}})

`docker run --rm --name fundo_azul -e APP_COLOR=blue -d -p 8081:8080 mmumshad/simple-webapp-color`{{execute}}

Veja a app [fundo_azul]({{TRAFFIC_HOST1_8081}})

#### Persistindo dados por volumes
Como já sabemos, containers são efêmeros, não persistem dados caso sejam removidos, para isso podemos mapear volumes no host ou até remotamente.

##### Dentro do diretório verifique o seguinte arquivo:

`cat ~/volume/index.html`{{execute}}

##### Mapeando o Volume

O Parâmetro "-v" irá fazer a ligação do volume local com o diretório dentro do container (vide documentação da imagem):

`docker run --rm --name nginx -d -p 80:80 -v ~/volume:/usr/share/nginx/html nginx`{{execute}}

Experimente alterar o arquivo no hospedeiro e visualizar a [aplicação]({{TRAFFIC_HOST1_80}})

##### Inspecione o ambiente e limpe

`docker network inspect bridge | jq`{{execute}}

`docker ps`{{execute}}

`docker stop fundo_rosa`{{execute}}

`docker stop fundo_azul`{{execute}}

`docker stop nginx`{{execute}}

`docker ps`{{execute}}

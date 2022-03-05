
### Docker Registry

##### Instanciando um Docker Registry

Vamos agora criar um docker registry local utilizando a [imagem oficial](https://hub.docker.com/_/registry) do docker, o registry possui inúmeras [configurações](https://docs.docker.com/registry/configuration/), como por exemplo autenticação via token, persistencia em bucket S3, aqui iremos configurar tudo de maneira simples apenas para provar o conceito.

##### Vamos instanciar o Docker Registry na porta padrão 5000:

`docker run -d -p 5000:5000 --restart always --name registry registry:2`{{execute}}

##### Verificando o Container

`docker ps`{{execute}}

##### Verificando a imagem da App

`docker images`{{execute}}

##### Retagiando a imagem com o endereço do Registry

`docker tag flask-app:v1 localhost:5000/flask-app:v1`{{execute}}

##### Verificando a imagem da App

`docker images`{{execute}}

##### Fazendo o Upload da Imagem para o Registry

`docker push localhost:5000/flask-app:v1`{{execute}}

##### Consultando o Registry

`curl http://localhost:5000/v2/_catalog | jq`{{execute}}

`curl http://localhost:5000/v2/flask-app/tags/list | jq`{{execute}}

##### Baixando a Imagem

`docker pull localhost:5000/flask-app:v1`{{execute}}

* É importande perceber que quando executamos um pull (download) de uma imagem sem qualquer endereço explícito ou tag como por exemplo:

```
docker pull nginx
```

* O Docker primeiro irá procura-la localmente, se não encontra-la irá em hub.docker.com, seu repositório padrão, caso não especificada, a tag será latest.
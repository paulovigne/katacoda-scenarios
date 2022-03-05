
### Rodando uma Imagem

##### Baixando uma imagem
Imagem do [nginx](https://hub.docker.com/_/nginx):

`docker pull nginx`{{execute}}

##### Executando uma imagem

`docker run nginx`{{execute}}

* O Comando "run" por si só já efetua o pull caso a imagem não exista no host.

##### Porque o shell ficou preso?
Para responder esta questão, vamos antes executar a aplicação "httping", que é uma ferramenta simples para teste de URLs.

`docker run bretfisher/httping` {{execute}}

Repare que foi retornado a versão da ferramenta e logo largou o shell.

`docker run bretfisher/httping google.com`{{execute}}

Agora o comando predendeu o shell em execução, isso deve-se por conta de como o ENTRYPOINT e o CMD do Dockerfile da imagem é definido.

### ENTRYPOINT vs CMD
Em um Dockerfile, podemos ter um ou outro ou ambos.

Vamos primeiro ver o [Dockerfile](https://github.com/nginxinc/docker-nginx/blob/master/mainline/debian/Dockerfile) do Nginx, procure no final do arquivo por ENTRYPOINT, veja que o aquivo [docker-entrypoint.sh](https://github.com/nginxinc/docker-nginx/blob/master/mainline/debian/docker-entrypoint.sh) é referenciado e no final dele temos '"exec "$@"' que absorve todos os parâmetros do CMD do Dockerfile, que é em si a chamada da daemom do Nginx Server que de fato prendeu o shell.

Agora vamos fazer o mesmo com o [Dockerfile](https://github.com/BretFisher/httping-docker/blob/main/Dockerfile) do Httping, repare que o ENTRYPOINT é um comando Shell direto do executável da aplicação, httping -Y, em seguida o CMD com o parâmentro --version. Ao executar o Docker run com o parâmentro google.com ao final, na verdade estamos sobrepondo o CMD do Dockerfile, sendo assim, podemos perceber que:

* ENTRYPOINT: Estático
* CMD: Parametrizável
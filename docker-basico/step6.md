
##### Criando uma imagem

Vamos agora criar uma aplicação bem simples em python utilizando o Flask, esta aplicação posuirá um único arquivo chamado "app.py" e seu Dockerfile com as instruções de build.

##### A aplicação app.py

`cat ~/build/app.py`{{execute}}

##### O Dockerfile

`cat ~/build/Dockerfile`{{execute}}

##### Iniciando o processo de build

`docker build -t flask-app ~/build/.`{{execute}}

##### Verificando a imagem gerada

`docker images`{{execute}}

##### Retagiando a Imagem

`docker tag flask-app flask-app:v1`{{execute}}

##### Rodando a Imagem
`docker run --rm --name flask-app -d -p 9090:8080 flask-app:v1`{{execute}}

##### Testando a aplicação

`curl 127.0.0.1:9090`{{execute}}

ou pelo link do [host]({{TRAFFIC_HOST1_9090}})

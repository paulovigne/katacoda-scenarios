Este ambiente é um playground para você treinar livremente o Kubernetes, ele está todo pronto, mas não possui um ingress controller, você está livre para instalar o ingress ou o que quiser, caso deseje um atalho para instalar o nginx-ingress controller, execute o seguinte script:

`sh ~/scripts/ingress.sh`{{execute}}

O domínio que você poderá utilizar para expor suas aplicações será o seguinde:

`APLICACAO.[[HOST2_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com`{{copy}}

Onde APLICACAO será o nome de sua escolha, crie quantos ingress hosts quiser!
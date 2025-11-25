#!/bin/bash

num=$(printf "%04d" $((RANDOM % 10000)))
echo "criando backup do projeto exemplo"
cp -r app/ apps-exemplos/app-backup-${num}/

echo "parando os containers"
docker-compose down

echo "removendo a pasta app"
sudo rm -rf app/

echo "criando a nova estrutura de desenvolvimento"
NOMEAPP="app"
mkdir -p $NOMEAPP
docker run --rm -v $(pwd):/$NOMEAPP composer create-project laravel/laravel $NOMEAPP

# echo "criando o arquivo de database"
# touch $NOMEAPP/database/database.sqlite

echo "subindo os containers"
docker-compose up -d
sleep 5

echo "copiando o arquivo .env"
docker cp .env.example app:/var/www/html/.env

docker exec app chown -R www-data:www-data /var/www/html
docker exec app chmod -R 777 /var/www/html

docker exec app php artisan optimize:clear

echo "Criando a chave de criptografia do Laravel"
docker exec app php artisan key:generate

docker cp new-branch.sh app:/var/www/html/new-branch.sh
docker exec app chmod +x new-branch.sh

echo "Copiando o script de criação de versionamento"
docker cp initiate-git-repo.sh app:/var/www/html/initiate-git-repo.sh
docker exec app chmod +x initiate-git-repo.sh

sudo chown -R $USER:$USER app/

echo "Copiando o arquivo de configurações"
docker cp config.sh app:/var/www/html/config.sh
docker-compose exec app chmod +x config.sh
docker-compose exec app ./config.sh
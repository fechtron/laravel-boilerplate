#!/bin/bash

num=$(printf "%04d" $((RANDOM % 10000)))
echo "criando backup do projeto exemplo"
cp -r app/ apps-exemplos/app-backup-${num}/

echo "parando os containers"
docker-compose down

echo "removendo a pasta app"
rm -r app/

echo "criando a nova estrutura de desenvolvimento"
NOMEAPP="app"
mkdir -p $NOMEAPP
docker run --rm -v $(pwd):/$NOMEAPP composer create-project laravel/laravel $NOMEAPP

echo "criando o arquivo de database"
touch $NOMEAPP/database/database.sqlite

echo "copiando o arquivo .env"
docker cp .env.example app:/var/www/html/.env

echo "subindo os containers"
docker-compose up -d

sleep 5
sudo chown -R $USER:$USER .
docker cp config.sh app:/var/www/html/config.sh
docker-compose exec app chmod +x config.sh
docker-compose exec app ./config.sh
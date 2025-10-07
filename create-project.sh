#!/bin/bash

NOMEAPP="app"

mkdir -p $NOMEAPP

sudo rm -rf app/

echo "Creating laravel project using docker"
docker run --rm -v $(pwd):/$NOMEAPP composer create-project laravel/laravel $NOMEAPP

touch $NOMEAPP/database/database.sqlite

docker cp .env.example app:/var/www/html/.env

docker-compose up -d

sleep 5
sudo chown -R $USER:$USER .
docker cp config.sh app:/var/www/html/config.sh
docker-compose exec app chmod +x config.sh
docker-compose exec app ./config.sh
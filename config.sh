#!/bin/bash


echo "Criando diretórios e dando permissões"
mkdir -p storage/framework/views

chown -R www-data:www-data storage bootstrap/cache
chmod -R 775 storage bootstrap/cache

chown -R www-data:www-data /var/www/html/resources/views
chmod -R 777 /var/www/html/resources/views

echo "Criando a chave de criptografia do Laravel"
php artisan key:generate

chmod -R 777 database/

chmod 664 database/database.sqlite
chown www-data:www-data database/database.sqlite

php artisan session:table
php artisan migrate

# Removendo arquivos de cache para permitir atualização automática da página quando atualizado fora do container
rm -f bootstrap/cache/config.php bootstrap/cache/routes-v7.php
php artisan optimize:clear
#!/bin/bash


chown -R www-data:www-data storage bootstrap/cache
chmod -R 775 storage bootstrap/cache

echo "Criando a chave de criptografia do Laravel"
php artisan key:generate

chmod -R 777 database/

chmod 664 database/database.sqlite
chown www-data:www-data database/
chown www-data:www-data database/database.sqlite

php artisan session:table
php artisan migrate

php artisan optimize:clear
# Use PHP 8.2 FPM image as the base
FROM php:8.2-fpm

# Set the working directory
WORKDIR /var/www/html

# Install system dependencies and SQLite extension
RUN apt-get update && apt-get install -y \
    git curl zip unzip libpng-dev libjpeg-dev libfreetype6-dev libonig-dev libxml2-dev \
    libzip-dev sqlite3 libsqlite3-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo_sqlite pdo_mysql mbstring exif pcntl bcmath gd zip

# install and enable xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Install Composer
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# Copy the project files into the container
COPY . .

# plusieurs FROM dans 1 même dockerfile = multiStage

FROM php:8.1-fpm as php_base

# Set working directory
WORKDIR /var/www

# Install system dependencies

# Version 20 de node (LongTimeSupport)
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get update && apt-get install -y git libzip-dev nodejs
RUN docker-php-ext-install zip pdo_mysql

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copie les fichiers depuis la racine du projet dans le workdir
COPY . .

# Installs les dépendances PHP & Node
RUN composer install
RUN npm ci && npm run build

# Donne les droits pour accéder au dossier storage
RUN chmod 777 -R storage

# Genere la clef artisan
RUN php artisan key:generate

# Autorise l'éxécution et lance le entrypoint.sh

# RUN chmod +x entrypoint.sh
# ENTRYPOINT ["./entrypoint.sh"]
# CMD ["php-fpm"]

FROM php_base as php1

COPY php1/welcome.blade.php resources/views/welcome.blade.php

FROM php_base as php2

COPY php2/welcome.blade.php resources/views/welcome.blade.php

FROM nginx as nginx1

COPY --from=php_base /var/www/public /var/www/public
COPY ./docker-compose/nginx1/test.conf /etc/nginx/conf.d/default.conf

FROM nginx as nginx2

COPY --from=php_base /var/www/public /var/www/public
COPY ./docker-compose/nginx2/test.conf /etc/nginx/conf.d/default.conf

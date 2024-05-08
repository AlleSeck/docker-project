# Utilise l'image officielle PHP 8.0 avec le serveur FPM intégré
FROM php:8.0-fpm

# Installer des dépendances nécessaires pour PHP et les extensions PHP
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    curl \
    unzip \
    git \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libzip-dev

#extensions PHP spécifiques pour Laravel
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Composer est un gestionnaire de dépendances pour PHP, copié depuis l'image officielle de Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Installer Node.js pour les dépendances front-end 
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

#répertoire de travail pour  les commandes
WORKDIR /var/www

# Mettre le code dans le conteneur
COPY . /var/www

# Exécuter Composer et npm pour installer les dépendances back et front-end
RUN composer install && npm install && npm run build

# Générer la clé d'application Laravel et exécuter les migrations de la base de données avec les seeders
RUN php artisan key:generate
RUN php artisan migrate:fresh --seed

# Exposer le port 9000 pour le service PHP-FPM
EXPOSE 9000

# Commande par défaut pour démarrer PHP-FPM
CMD ["php-fpm"]

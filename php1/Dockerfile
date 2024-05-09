# Utilisation de l'image de base officielle PHP avec PHP 8.0 FPM
FROM php:8.0-fpm

# Installation de Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Installation des dépendances nécessaires pour les extensions PHP courantes
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Installation des extensions PHP
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Copie du script d'initialisation
COPY start-script.sh /usr/local/bin/start-script
RUN chmod +x /usr/local/bin/start-script

# Définition du répertoire de travail
WORKDIR /var/www

# Commande à exécuter au démarrage du conteneur
CMD ["sh", "/usr/local/bin/start-script"]

# Utilisation de l'image de base officielle PHP avec PHP 8.0 FPM
FROM php:8.0-fpm

# Installation de Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Installation de Node.js et npm pour les besoins de front-end
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

# Installation des extensions PHP nécessaires
RUN apt-get update && apt-get install -y libzip-dev \
    && docker-php-ext-install zip

# Installation supplémentaire spécifique pour php2
RUN docker-php-ext-install opcache

# Copie du script d'initialisation
COPY start-script2.sh /usr/local/bin/start-script2
RUN chmod +x /usr/local/bin/start-script2

# Définition du répertoire de travail
WORKDIR /var/www

# Commande à exécuter au démarrage du conteneur
CMD ["sh", "/usr/local/bin/start-script2"]


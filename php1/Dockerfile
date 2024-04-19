FROM php:7.4-fpm

# Arguments defined in docker-compose.yml
ARG user
ARG uid

RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN docker-php-ext-enable mysqli pdo pdo_mysql

###il me faut un script pour demarrer le conteneur
#CMD php artisan migrate:fresh —seed

# Install system dependencies
RUN apt-get update && apt-get install -y 

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*


# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create system user to run Composer and Artisan Commands
#RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

# Set working directory
WORKDIR /var/www

USER $user
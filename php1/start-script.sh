#!/bin/bash
# Installation des dépendances Composer
composer install
# Génération de la clé d'application Laravel
php artisan key:generate
# Migration et seeding de la base de données
php artisan migrate:fresh --seed



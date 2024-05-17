#!/bin/bash
set -e
php artisan migrate:fresh --seed

# Execute le CMD
exec "$@";

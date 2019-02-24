#!/bin/bash

# bail on any error rather than continuing
set -e

# install PHP dependencies
composer install --no-interaction --optimize-autoloader

# create storage dir
if [ ! -d "storage" ]; then
    mkdir ./storage
fi

# install Craft
php craft install --email=nobody@example.com --username=supersecret --password=supersecret --siteName="Interweb Shoppe" --siteUrl=SITE_URL --language=en-US

# install Snipcart plugin
php craft install/plugin snipcart

#!/bin/bash
set -e

cd "$SITE_PATH"

./craft migrate/all
./craft project-config/apply
./craft clear-caches/all # Not too bothered about this because it's a plugin dev site

sudo -S service php7.4-fpm reload

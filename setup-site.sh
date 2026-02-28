#!/bin/bash
set -e

SITE_NAME="${1:?Usage: ./setup-site.sh <site-name> <db-root-password> <admin-password>}"
DB_ROOT_PASSWORD="${2:?Missing db root password}"
ADMIN_PASSWORD="${3:?Missing admin password}"

echo "Creating site: $SITE_NAME"
bench new-site "$SITE_NAME" \
    --mariadb-root-password "$DB_ROOT_PASSWORD" \
    --admin-password "$ADMIN_PASSWORD" \
    --install-app lms \
    --install-app gocab_learning

echo "Enabling scheduler"
bench --site "$SITE_NAME" enable-scheduler

echo "Setting default site"
bench use "$SITE_NAME"

echo "Running migrations"
bench --site "$SITE_NAME" migrate

echo "Done! Access your site at https://$SITE_NAME"

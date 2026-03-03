#!/bin/bash
set -e

SITE_NAME="${1:?Usage: ./setup-site.sh <site-name> <db-name> <db-user> <db-password> <admin-password> [db-type]}"
DB_NAME="${2:?Missing db name}"
DB_USER="${3:?Missing db user}"
DB_PASSWORD="${4:?Missing db password}"
ADMIN_PASSWORD="${5:?Missing admin password}"
DB_TYPE="${6:-postgres}"

echo "Creating site: $SITE_NAME (db: $DB_TYPE, database: $DB_NAME)"

bench new-site "$SITE_NAME" \
    --db-type "$DB_TYPE" \
    --db-name "$DB_NAME" \
    --db-user "$DB_USER" \
    --db-password "$DB_PASSWORD" \
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

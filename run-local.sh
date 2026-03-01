#!/bin/bash
set -e

docker compose -f docker-compose.dokploy.yaml -f docker-compose.local.yaml up -d --build

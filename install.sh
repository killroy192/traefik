#!/usr/bin/env bash

ENV_FILE='.env'
TRAEFIK_CONFIG_FILE='.config/traefik.toml'

make_env() {
    if [ -f "$@" ]; then
        echo "$@ already exists, skipped creation."
    else
        echo "Creating $@..."
        cp -n "$@.example" "$@"
    fi   
}

echo ""
echo "prepearing envs"
make_env $ENV_FILE
make_env $TRAEFIK_CONFIG_FILE
echo ""

export $(egrep -v '^#' .env | xargs)

echo ""
echo "create acme file"
touch config/acme.json
chmod 600 config/acme.json
echo ""

echo ""
echo "create network $NETWORK_NAME"
docker network create $NETWORK_NAME
echo ""
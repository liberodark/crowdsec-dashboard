#!/bin/sh

set -e

# Variables
export TYPE="h2"
export DB="/opt/crowdsec/metabase.db"
export HOST="0.0.0.0"
export PORT="3000"
# Set min + max java heap size. Recommended to be half your RAM.
export JAVAMIN="256m"
export JAVAMAX="256m"

java -Xms$JAVAMIN -Xmx$JAVAMAX -DMB_JETTY_HOST="$HOST" -DMB_DB_TYPE="$TYPE" -DMB_DB_FILE="$DB" -DMB_JETTY_PORT="$PORT" -jar metabase.jar >> /var/log/metabase.log

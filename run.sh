#!/bin/sh

TYPE="h2"
DB="/opt/crowdsec/metabase.db"
HOST="0.0.0.0"
PORT="3000"

touch /var/log/metabase.log
chown crowdsec:crowdsec /var/log/metabase.log

MB_JETTY_HOST="$HOST" MB_JETTY_PORT="$PORT" MB_DB_TYPE="$TYPE" MB_DB_FILE="$DB" java -DMB_JETTY_HOST="$HOST" -DMB_JETTY_PORT="$PORT" -jar metabase.jar >> /var/log/metabase.log

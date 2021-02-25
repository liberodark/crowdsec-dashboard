#!/bin/sh

TYPE="h2"
DB="/opt/crowdsec/metabase.db"

MB_DB_TYPE="$TYPE" MB_DB_FILE="$DB" java -jar metabase.jar
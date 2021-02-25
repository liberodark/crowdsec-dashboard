#!/bin/sh

sudo mkdir -p /opt/crowdsec
sudo cp run.sh /opt/crowdsec
sudo cp ./*.db /opt/crowdsec
sudo cp crowdsec-dashboard.service /etc/systemd/system/
cd /opt/crowdsec || exit
wget https://downloads.metabase.com/v0.38.0.1/metabase.jar
# If you want to no use preinstalled DB
#wget https://crowdsec-statics-assets.s3-eu-west-1.amazonaws.com/metabase_sqlite.zip
#unzip metabase_sqlite.zip && rm -f metabase_sqlite.zip || exit
#cp /opt/crowdsec/metabase.db/metabase.db.mv.db /opt/crowdsec/metabase.db.mv.db || exit
#rm -rf metabase.db || exit
#mv metabase.db.mv.db metabase.db || exit
sudo ln -s /var/lib/crowdsec/data/crowdsec.db /opt/crowdsec/crowdsec.db || exit
sudo groupadd -r crowdsec
sudo useradd -r -g crowdsec -d /opt/crowdsec -s /sbin/nologin crowdsec
sudo chmod +x /opt/crowdsec/run.sh
sudo chown -R crowdsec: /opt/crowdsec
sudo chown crowdsec: /var/lib/crowdsec/data/crowdsec.db
sudo systemctl enable --now crowdsec-dashboard

#!/bin/sh

sudo mkdir -p /opt/crowdsec/metabase-data/
sudo cp run.sh /opt/crowdsec
#sudo cp ./*.db /opt/crowdsec
sudo cp crowdsec-dashboard.service /etc/systemd/system/
cd /opt/crowdsec || exit
sudo wget https://downloads.metabase.com/v0.40.1/metabase.jar
# If you want to no use preinstalled DB
sudo wget https://crowdsec-statics-assets.s3-eu-west-1.amazonaws.com/metabase_sqlite.zip
sudo unzip metabase_sqlite.zip && rm -f metabase_sqlite.zip || exit
sudo cp /opt/crowdsec/metabase.db/metabase.db.mv.db /opt/crowdsec/metabase.db.mv.db || exit
#sudo rm -rf /opt/crowdsec/metabase.db || exit
#sudo rm -rf /opt/crowdsec/metabase.db.trace.db || exit
sudo ln -s /var/lib/crowdsec/data/crowdsec.db /opt/crowdsec/metabase-data/crowdsec.db || exit
sudo groupadd -r crowdsec
sudo useradd -r -g crowdsec -d /opt/crowdsec -s /sbin/nologin crowdsec
sudo chmod +x /opt/crowdsec/run.sh
sudo chown -R crowdsec: /opt/crowdsec
sudo chown crowdsec: /var/lib/crowdsec/data/crowdsec.db
sudo systemctl enable --now crowdsec-dashboard

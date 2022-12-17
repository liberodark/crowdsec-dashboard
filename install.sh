#!/bin/sh

set -e

# Variables
METABASEVER="0.45.1"
METABASEJAR="https://downloads.metabase.com/v$METABASEVER/metabase.jar"
METABASEDB="https://crowdsec-statics-assets.s3-eu-west-1.amazonaws.com/metabase_sqlite.zip"
SERVERIP="$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)"

# Check if script is being run as root
if [ "$(id -u)" -eq 0 ]; then
    echo "Running with sudo. Continuing..."
else
    echo "This script requires elevated priviledges."
    echo "Please run this script with sudo." >&2
    exit 1
fi

# Check if required packages are installed - install if they aren't.
package_check() {
    PKG_LIST='unzip wget openjdk-11-jre-headless'
    # if input is a file, convert it to a string like:
    # PKG_LIST=$(cat ./packages.txt)
    # PKG_LIST=$1
    for package in $PKG_LIST; do
        CHECK_PACKAGE=$(sudo dpkg -l \
        | grep --max-count 1 "$package" \
        | awk '{print$ 2}')

        if [ -n "$CHECK_PACKAGE" ];
        then
            echo "$package" 'is installed...';
        else
            echo "$package" 'Is NOT installed, installing...';
            apt-get -y install --no-install-recommends "$package"
        fi
    done
}

echo "Checking for prerequisite packages..."
package_check

# Create Directories and copy files in
mkdir -p /opt/crowdsec/metabase-data/
cp run.sh /opt/crowdsec

# Downloading and setting up Metabase
cd /opt/crowdsec || exit
wget $METABASEJAR
wget $METABASEDB
unzip metabase_sqlite.zip
rm -f metabase_sqlite.zip
mv /opt/crowdsec/metabase.db/metabase.db.mv.db /opt/crowdsec/metabase.db.mv.db
rm -rf /opt/crowdsec/metabase.db/
ln -s /var/lib/crowdsec/data/crowdsec.db /opt/crowdsec/metabase-data/crowdsec.db

# Setting up Crowsec dashboard service
tee /etc/systemd/system/crowdsec-dashboard.service << EOF
[Unit]
Description=crowdsec-dashboard
After=network.target

[Service]
WorkingDirectory=/opt/crowdsec/
User=crowdsec
Group=crowdsec
Type=simple
UMask=000
ExecStart=/opt/crowdsec/run.sh
RestartSec=120
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Adding and configuring groups
groupadd -r crowdsec
useradd -r -g crowdsec -d /opt/crowdsec -s /sbin/nologin crowdsec
chmod +x /opt/crowdsec/run.sh
chown -R crowdsec: /opt/crowdsec
chown crowdsec: /var/lib/crowdsec/data/crowdsec.db

# Set up logs
touch /var/log/metabase.log
chown crowdsec:crowdsec /var/log/metabase.log

# Enable Crowsec dashboard service
systemctl enable --now crowdsec-dashboard

# Final message for users
echo "==================================================="
echo "Dashboard is available at http://$SERVERIP:3000/"
echo "Username: crowdsec@crowdsec.net"
echo "Password: !!Cr0wdS3c_M3t4b4s3??"
echo "==================================================="
echo "Edit Dashboard settings:"
echo "Go to \"Database\", change \"/metabase-data/crowdsec.db\""
echo "To \"/opt/crowdsec/metabase-data/crowdsec.db\""
echo "==================================================="
exit 0
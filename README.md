# crowdsec-dashboard

Debian requirements :
```
sudo apt install openjdk-11-jre-headless -y
sudo apt install unzip -y
```

```
git clone https://github.com/liberodark/crowdsec-dashboard
cd crowdsec-dashboard && chmod +x install.sh
./install.sh
```

- Dashboard is available in http://crowdsec.lan:3000/
- user : `crowdsec@crowdsec.net`
- password : `!!Cr0wdS3c_M3t4b4s3??`

Edit settings and go to database to change /metabase-data/crowdsec.db to /opt/crowdsec/metabase-data/crowdsec.db

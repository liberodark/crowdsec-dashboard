# crowdsec-dashboard

### Debian requirements (installed by script):
- curl
- jq
- openjdk-11-jre-headless
- unzip
- wget

### Download and Run script

```bash
curl -s https://raw.githubusercontent.com/liberodark/crowdsec-dashboard/main/install.sh | sudo bash
```

- Dashboard is available at http://<serverIP>:3000/
- user : `crowdsec@crowdsec.net`
- password : `!!Cr0wdS3c_M3t4b4s3??`

<p align="center">
  <img width="50%" height="50%" src="https://raw.githubusercontent.com/erdoukki/crowdsec-dashboard/main/Screenshot%202021-07-23%20at%2018-54-32%20Metabase.png">
</p>

### Modify script

If you wish to modify the service, you can do this in one of two ways. 

Before Installation:

```bash
curl -s https://raw.githubusercontent.com/liberodark/crowdsec-dashboard/main/install.sh > /tmp/install.sh
nano /tmp/install.sh
sudo sh /tmp/install.sh
```

After installation:

```bash
nano /opt/crowdsec/run.sh
sudo service crowdsec-dashboard restart
```

Logs can be found in `/var/log/metabase.log`.

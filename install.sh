#!/usr/bin/env bash


echo "
----------------------
  NODE & NPM
----------------------
"

# add nodejs 10 ppa (personal package archive) from nodesource
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -

# install nodejs and npm
sudo apt-get install -y nodejs


echo "
----------------------
  MONGODB
----------------------
"

# import mongodb 4.0 public gpg key
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4

# create the /etc/apt/sources.list.d/mongodb-org-4.0.list file for mongodb
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list

# reload local package database
sudo apt-get update

# install the latest version of mongodb
sudo apt-get install -y mongodb-org

# start mongodb
sudo systemctl start mongod

# set mongodb to start automatically on system startup
sudo systemctl enable mongod


echo "
----------------------
  PM2
----------------------
"

# install pm2 with npm
sudo npm install --location=global pm2

# set pm2 to start automatically on system startup
sudo pm2 startup systemd


echo "
----------------------
  NGINX
----------------------
"

# install nginx
sudo apt-get install -y nginx


echo "
----------------------
  UFW (FIREWALL)
----------------------
"

# allow ssh connections through firewall
sudo ufw allow OpenSSH

# allow http & https through firewall
sudo ufw allow 'Nginx Full'

# enable firewall
sudo ufw --force enable


echo "
---------------------
    NGINX Routing
---------------------
"

rm -rf /etc/nginx/sites-available/default

cd /etc/nginx/sites-available/

wget https://creant.asia/server_install/default.txt

cp default.txt default

service nginx restart


cd /opt

mkdir backend

cd backend

wget https://creant.asia/server_install/core.zip

apt-get install unzip

unzip core.zip -d /opt/backend


npm install

pm2 start index.js

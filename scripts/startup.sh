#! /bin/bash

cd /home/appuser

# Add repo for MongoDB
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'
sudo apt update # update apt

# Install Ruby, Bundler and MongoDB
sudo apt install -y ruby-full ruby-bundler build-essential mongodb-org

sudo systemctl start mongod # start MongoDB
sudo systemctl enable mongod # enable autostart

git clone -b monolith https://github.com/express42/reddit.git # clone code
cd reddit && bundle install # install deps

puma -d # start server

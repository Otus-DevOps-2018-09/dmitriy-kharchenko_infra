#!/bin/bash
# Установка MongoDB
# Добавление ключей в репозиторий
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'

# Установка MongoDB
sudo apt update # обновление apt
sudo apt install -y mongodb-org

sudo systemctl start mongod # запуск MongoDB
sudo systemctl enable mongod # добавление в автозапуск

#!/bin/bash
# Установка MongoDB
# Добавление ключей в репозиторий
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'

# Установка MongoDB
apt update # обновление apt
apt install -y mongodb-org

systemctl enable mongod # добавление в автозапуск

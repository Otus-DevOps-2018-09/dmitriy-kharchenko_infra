#!/bin/bash
# деплой приложения
cd /home/appuser

git clone -b monolith https://github.com/express42/reddit.git # клонирование репозитория с кодом
cd reddit && bundle install # установка зависимостей

systemctl enable puma # добавление в автозапуск

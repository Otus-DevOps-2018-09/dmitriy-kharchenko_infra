#!/bin/bash
# деплой приложения
git clone -b monolith https://github.com/express42/reddit.git # клонирование репозитория с кодом
cd reddit && bundle install # установка зависимостей

puma -d # запуск сервера, порт по умолчанию 9292

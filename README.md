# dmitriy-kharchenko_infra
dmitriy-kharchenko Infra repository

# Подключение к someinternalhost в одну команду

Для подключения к someinternalhost в одну команду `ssh someinternalhost` необходимо добавить следющую конфигурацию в `~/.ssh/config`

```
Host bastion
  User appuser
  Hostname 35.210.215.107 # внешний адрес bastion хоста

Host someinternalhost
  User appuser
  Hostname 10.132.0.3 # внутренний адрес someinternalhost
  Port 22
  ProxyCommand ssh -q -W %h:%p bastion
```

# Конфигурация VPN

bastion_IP = 35.210.215.107
someinternalhost_IP = 10.132.0.3


# Создание инстанса с запуском startup скрипта
```
gcloud compute instances create reddit-app \
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=./startup.sh
```

# Создание правила файервола
```
gcloud compute --project=infra-219305 firewall-rules create default-puma-server --direction=INGRESS --priority=1000 \
--network=default --action=ALLOW --rules=tcp:9292 --source-ranges=0.0.0.0/0 --target-tags=puma-server
```

testapp_IP = 35.241.207.235
testapp_port = 9292

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
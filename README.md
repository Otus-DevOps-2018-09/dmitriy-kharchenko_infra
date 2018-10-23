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

# Конфигурация Packer

Все файлы конфигурации packer хранятся в каталоге packer.

Скрипт `config-scripts/create-reddit-vm.sh` создает инстанс с запущенным приложением.

```
├── files
│   └── puma.service # юнит для запуска сервера puma
├── immutable.json # bake конфигурация
├── scripts
│   ├── deploy.sh # скрипт для установки приложения
│   ├── install_mongodb.sh # скрипт для установки MongoDB
│   └── install_ruby.sh # скрипт для установки Ruby
├── ubuntu16.json # base конфигурация
└── variables.json.example # обязательные переменные для файлов конфигураций packer
```

# Создание базового образа с помощью packer

В файле ubuntu16.json описана конфигурация для создания образа с зависимостями приложения reddit.
После создания виртуальной машины приложение надо установить отдельно c помощью скрипта `scripts/deploy.sh`

```
packer build -var-file variables.json ubuntu16.json
```

# Создание application образа с помощью packer

В файле immutable.json описана конфигурация для создания образа приложения reddit.
После создания виртуальной машины приложение уже запущено и работает.
```
packer build -var-file variables.json immutable.json
```

# Terraform

После опсиания в конфигурации ключа пользователя appuser2 и выполнения команды `terraform apply`, ключ заменен на ключ пользователя appuser1.

После добавления ключа appuser_web через web-интерфейс и выполнения команды `terraform apply` в метаданные проекта добавился ключ appuser1

# Load Balancer

Недостатком данной конфигурации является наличие внешних адресов у backend серверов.

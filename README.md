# LostKali_infra
LostKali Infra repository

# HW03

Запуск VM в Yandex Cloud, управление правилами фаервола, настройка SSH подключения, настройка SSH подключения через Bastion Host, настройка VPN сервера и VPN-подключения.

## Connect to internal host
According to [the article](https://www.tecmint.com/access-linux-server-using-a-jump-host/) write `~/.ssh/config` as following:
```
############################ OTUS DEVOPS ########################
### jump host: bastion - directly reachable
Host bastion
    HostName 62.84.115.113
    IdentityFile ~/.ssh/otus_devops
    User otus_devops

### target host: someinternalhost - reachable from the internal network (from bastion)
Host someinternalhost
    HostName 10.128.0.21
    User otus_devops
    ProxyCommand ssh -q -W %h:%p bastion
```

bastion_IP = 62.84.115.113
someinternalhost_IP = 10.128.0.21

# HW04

Практика управления ресурсамиyandex cloud через yc.

testapp_IP = 51.250.85.170
testapp_port = 9292

Для создания, настройки VM и последующего деплоя приложения необходимо выполнить команду (из папки, где расположен `init.yaml`):
```
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --metadata-from-file user-data=./init.yaml \
  --ssh-key ~/.ssh/otus_devops.pub
```
Формат `init.yaml` соответствует [cloud-init](https://cloudinit.readthedocs.io/en/latest/topics/examples.html)

# HW05

Подготовка базового образа VM при помощи Packer.

- создан packer скрипт для создания базового образа
- packer скрипт шаблонизирован с использованием пользовательских переменных
- переменные прописаны в файле, в репозитории представлен пример этого файла

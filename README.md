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

- создан packer шаблон для создания базового образа
- packer шаблон обобщен с использованием пользовательских переменных
- переменные прописаны в файле, в репозитории представлен пример этого файла
- создан packer шаблон для создания образа с предустановленным приложением, которое будет доступна сразу после страта вм
- создан скрипт для создания vm с помощью CLI [дока](https://github.com/yandex-cloud/docs/blob/master/ru/compute/operations/vm-create/create-from-user-image.md#%D1%81%D0%BE%D0%B7%D0%B4%D0%B0%D0%B9%D1%82%D0%B5-%D0%B2%D0%B8%D1%80%D1%82%D1%83%D0%B0%D0%BB%D1%8C%D0%BD%D1%83%D1%8E-%D0%BC%D0%B0%D1%88%D0%B8%D0%BD%D1%83-%D0%B8%D0%B7-%D0%BF%D0%BE%D0%B4%D0%B3%D0%BE%D1%82%D0%BE%D0%B2%D0%BB%D0%B5%D0%BD%D0%BD%D0%BE%D0%B3%D0%BE-%D0%BE%D0%B1%D1%80%D0%B0%D0%B7%D0%B0-create-vm-from-image). В качестве параметра скрипт получает id образа, на основе которого будет создана vm. Например:
```
./create-reddit-vm.sh fxxxxxxxxxxxxxxxxxxx0
```

# LostKali_infra
LostKali Infra repository

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

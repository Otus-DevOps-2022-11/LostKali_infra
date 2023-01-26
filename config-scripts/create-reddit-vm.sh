yc compute instance create \
  --name reddit-full-$(date +%Y%m%d-%H%M%S) \
  --hostname reddit-full \
  --platform=standard-v3 \
  --memory=4 \
  --create-boot-disk image-id="$1",size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --zone ru-central1-a \
  --ssh-key ~/.ssh/otus_devops.pub

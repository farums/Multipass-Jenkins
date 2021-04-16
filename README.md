
## 📘 Documentation
[galaxy](https://galaxy.ansible.com)
[обновления Windows Error](https://multipass.run/docs/troubleshooting-networking-on-windows)
[docker-login:00:37 мин](https://deworker.pro/edu/series/interactive-site/ansible-provisioning)
[cloudinit](https://cloudinit.readthedocs.io/en/latest/topics/examples.html)
[docker-ansible](https://github.com/cytopia/docker-ansible)

## hosts
C:\WINDOWS\System32\drivers\etc\hosts.ics
# Ansible Install package

Docker version 19.03.15, build 99e3ed8919
docker-compose version 1.27.4, build 40524192
https://github.com/aixoss/cloud-init/blob/d93803a9ec5f58b37ff95a5e71808da1b4efb7c6/tests/data/merge_sources/source7-1.yaml

## ssh

`~/.ssh/id_rsa.pub` — открытый ключ. Его копируют на сервера, куда нужно получить доступ.
`~/.ssh/id_rsa` — закрытый ключ.

`ssh -i /mnt/c/Users/Elmut/Desktop/Games/Multipass/docker-registry/keys/id_rsa_docker -p 22 ubuntu@172.22.234.153  ll`

## github

https://github.com/youurayy/hyperctl/blob/f0d787987c1a3d23fc51638c1ee0a0e93e88a793/hyperctl.ps1
https://github.com/rajasoun/multipass-dev-box
[ssh](https://github.com/mgor/ansible-playground/blob/0d8796798636cc6ab13df2ef6b0d3cc7cc816ac5/create-environment.bash)

## github ansible

https://github.com/andornaut/ansible-role-docker
# ansible

[galaxy](https://galaxy.ansible.com/search?deprecated=false&keywords=registry&order_by=-relevance&page=1)

https://github.com/andornaut/ansible-workstation

## Command  Multipass.exe

```bash
multipass delete --all -p
multipass.exe purge
multipass.exe ls
```

UNT=cloudify-files
```bash
NAME=ubuntu-New
MOUNT=dir-local

multipass mount $MOUNT $NAME_WM:/home/ubuntu/$MOUNT
```
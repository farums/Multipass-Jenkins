
## 📘 Documentation
[обновления Windows Error](https://multipass.run/docs/troubleshooting-networking-on-windows)
[YAML VsCode ansible](https://www.jung-christian.de/post/2021/02/ansible-vscode/)
[YAML schemas](https://www.schemastore.org/json/)

## github
https://github.com/search?q=%22vscode-remote%22+dev-container&type=code
https://github.com/komadamnak/sns-server/blob/928920bbb3b8a3229213fa4f7ebc63982d473bf6/script/vscode.sh
https://github.com/cgmon/magic/blob/f679d039a0174784d94a18c2e27728b80f4b2b6c/setup-project.ps1
https://github.com/yuusakuri/PSWinUtil/blob/17954fafad722ff520a181b5e6a54f0ce7ff9539/functions/Start-WUDevcontainer.ps1

## ubuntu@jenkins:
ubuntu@jenkins:`sudo cat /root/.ssh/authorized_keys`
ubuntu@jenkins:`cat /etc/nginx/auth/.htpasswd`


## yml

```yml
- name: Install Docker system packages
  apt:
    name:
      - docker-registry
    state: latest
  become: true

- name: Start Docker Registry on boot
  systemd:
    name: docker-registry
    daemon_reload: yes
    state: started
    enabled: yes
  become: true
  ```
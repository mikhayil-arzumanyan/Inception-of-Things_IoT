#!/bin/sh

sudo su

# If K3S_URL not set, it will default to “server.”
export K3S_KUBECONFIG_MODE="644"
export INSTALL_K3S_EXEC="server --bind-address=$SERVER --node-external-ip=$SERVER --flannel-iface=eth1"

# Тихо скачивает файл, обрабатывает HTTP-ошибки как сбои и автоматически следовает за всеми возможными перенаправлениями, которые могут произойти во время процесса загрузки.
curl -sfL https://get.k3s.io | sh -

sleep 10

# Мы указываем брандмауэру разрешить входящий TCP-трафик на порт 6443 в зоне "public", и это правило будет действовать даже после перезагрузок брандмауэра.
firewall-cmd --zone=public --add-port=6443/tcp --permanent

# Эта команда позволяет обновить брандмауэр на лету, без необходимости перезагрузки всей системы.
firewall-cmd --reload

cp /var/lib/rancher/k3s/server/token /tmp/shared/
cp /etc/rancher/k3s/k3s.yaml /tmp/shared/

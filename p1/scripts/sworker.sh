#!/bin/sh

sudo -i
# If the command is not specified, and the K3S_URL is set, it will default to “agent.”
export K3S_TOKEN_FILE=/tmp/shared/token
export K3S_URL=https://$SWORKER:6443
export INSTALL_K3S_EXEC="--flannel-iface=eth1"

# Тихо скачивает файл, обрабатывает HTTP-ошибки как сбои и автоматически следовает за всеми возможными перенаправлениями, которые могут произойти во время процесса загрузки.
curl -sfL https://get.k3s.io | sh -

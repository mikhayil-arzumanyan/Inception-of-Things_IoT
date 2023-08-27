#!/bin/bash

export NAME="miarzumaSW"
echo "DOING -->  Installing k3s on server worker node (ip: $2)"

export TOKEN_FILE="/vagrant/scripts/node-token"

echo "DOING -->  Token: $(cat $TOKEN_FILE)"

export INSTALL_K3S_EXEC="agent --server https://$1:6443 --token-file $TOKEN_FILE --node-ip=$2"

echo "DOING -->  ARGUMENT PASSED TO INSTALL_K3S_EXEC: $INSTALL_K3S_EXEC"

apk add curl

curl -sfL https://get.k3s.io | sh -

echo "alias k='kubectl'" >> /etc/profile.d/00-aliases.sh


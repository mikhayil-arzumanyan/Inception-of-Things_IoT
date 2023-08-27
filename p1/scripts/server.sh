#!/bin/bash

echo "DOING -->  Installing k3s on server node (ip: $1)"

export INSTALL_K3S_EXEC="--write-kubeconfig-mode=644 --tls-san $(hostname) --node-ip $1  --bind-address=$1 --advertise-address=$1 "

echo "DOING -->  ARGUMENT PASSED TO INSTALL_K3S_EXEC: $INSTALL_K3S_EXEC"

apk add curl

curl -sfL https://get.k3s.io |  sh -

echo "DOING -->  Doing some sleep to wait for k3s to be ready"

sleep 10

sudo cp /var/lib/rancher/k3s/server/node-token /vagrant/scripts/

echo "DOING -->  Successfully installed k3s on server node"

echo "alias k='kubectl'" >> /etc/profile.d/00-aliases.sh


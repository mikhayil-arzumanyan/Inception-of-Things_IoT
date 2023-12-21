#!/bin/bash

echo "DOING -->  Installing k3s on server node (ip: $1)"

export INSTALL_K3S_EXEC="--write-kubeconfig-mode=644 --tls-san $(hostname) --node-ip $1  --bind-address=$1 --advertise-address=$1 "

echo "DOING -->  ARGUMENT PASSED TO INSTALL_K3S_EXEC: $INSTALL_K3S_EXEC"

apk add curl

curl -sfL https://get.k3s.io |  sh -

echo "DOING -->  Doing some sleep to wait for k3s to be ready"

echo "DOING -->  Successfully installed k3s on server node"

echo "alias k='kubectl'" >> /etc/profile.d/00-aliases.sh

sleep 10

kubectl apply -f /vagrant/confs/app1.yml; sleep 2

kubectl apply -f /vagrant/confs/app2.yml; sleep 2

kubectl apply -f /vagrant/confs/app3.yml; sleep 2

kubectl apply -f /vagrant/confs/ingress.yml; sleep 2

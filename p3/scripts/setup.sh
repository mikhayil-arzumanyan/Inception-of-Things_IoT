#! /bin/bash

# install docker
echo "installing docker"

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y
sudo apt-cache policy docker-ce -y
sudo apt-get install -y docker-ce

#install kubectl
echo "installing kubectl"

sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl


# install k3d
echo "installing k3d"
sudo curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash


#Create k3d clutser with port forwarding
#Install argocd CLI
sudo url -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
sudo rm argocd-linux-amd64sudo k3d cluster create -p "8080:443@loadbalancer" -p "8888:8888@loadbalancer"

#Create namespaces:
sudo kubectl create ns argocd
sudo kubectl create ns dev

#Setting up Argo CD
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stabil/manifests/install.yaml

#Make password in argocd

PASSWD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
echo $PASSWD > ./argo_pass.txt
echo "Username = admin"
echo "Password = (go to argo_pass.txt file)"

#Create the app in argocd
sudo kubectl apply -f ../confs/app.yaml -n argocd

#Create Argo CD App
sudo argocd app create wil-playground \
       --repo https://github.com/mikhayil-arzumanyan/IoT-test-for-Inception-of-Things_IoT \
       --path manifests \
       --dest-server https://kubernetes.default.svc \
       --dest-namespace dew222222222222222222222

#Argocd-server for browser
sudo kubectl port-forward service/argocd-server -n argocd 8080:443


#! /bin/bash

#Do k instead of kubectl
echo "#miarzuma" >> ~/.bashrc
echo "alias sudo='sudo '" >> ~/.bashrc
echo "alias k='sudo kubectl'" >> ~/.bashrc
sudo cp "/root/.bashrc" "/home/$SUDO_USER/.bashrc"

# install docker
echo "installing docker"
apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y
apt-cache policy docker-ce -y
apt-get install -y docker-ce

#install kubectl
echo "installing kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl

# install k3d
echo "installing k3d"
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

#Create k3d clutser with port forwarding
k3d cluster create -p "8880:443@loadbalancer" -p "8888:8888@loadbalancer"

#Create namespaces:
kubectl create ns argocd
kubectl create ns dev

#Setting up Argo CD
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sleep 5

#Install argocd CLI
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64 

#Make password in argocd
PASSWD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
echo $PASSWD > ./argo_pass.txt
echo "Username = admin"
echo "Password = (go to /p3/scripts/argo_pass.txt file)"

#Create the app in argocd
kubectl apply -f ../confs/app.yaml -n argocd

#Argocd-server for browser
kubectl port-forward service/argocd-server -n argocd 8080:443


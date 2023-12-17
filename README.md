 # Inception-of-Things_IoT
 
Part 1
Run two virtual machines using Vagrant and install K3S on them the first one will be installed in controller mode and the second in agent mode.

Part 2
Run one virtual machine with K3s in server mode installed. You will set up 3 web applications that will run in your K3s instance. You will have to be able to access them depending on the HOST used when making a request to the IP address 192.168.56.110. When a client inputs the ip 192.168.56.110 in his web browser with the HOST app1.com, the server must display the app1. When the HOST app2.com is used, the server must dis- play the app2. Otherwise, the app3 will be selected by default. (you need to setup /etc/hosts)

Part 3
We will learn new tools, K3D and docker.
To use K3D, you will need a docker version >= 20.1.X so we can't use alpine linux anymore. We will use ubuntu instead.
We will create a cluster and two namespaces, one for argocd and the other one for our apps.
You should save the yaml file in order to be able to deploy it later, directly from argocd.

Bonus
The bonus part is to create a CI/CD pipeline with our builded version of Gitlab, it will be used to deploy our app with Gitlab.

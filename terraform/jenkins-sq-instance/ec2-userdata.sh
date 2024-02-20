#!/bin/bash
sudo apt-get update
# sudo apt install -y default-jdk
# sudo apt install -y openjdk-11-jdk
sudo apt install openjdk-17-jre -y
sudo apt install openjdk-17-jdk -y

# Installing Jenkins
sudo curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee   /usr/share/keyrings/jenkins-keyring.asc > /dev/null
sudo echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]   https://pkg.jenkins.io/debian-stable binary/ | sudo tee   /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Installing Docker
sudo apt update
sudo apt install docker.io -y
sudo usermod -aG docker jenkins
sudo usermod -aG docker ubuntu
sudo systemctl restart docker
sudo chmod 777 /var/run/docker.sock


## Alternative for Installing Docker
# sudo apt-get update
# sudo apt-get install ca-certificates curl gnupg
# sudo install -m 0755 -d /etc/apt/keyrings
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
# sudo chmod a+r /etc/apt/keyrings/docker.gpg
# echo \
#   "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
#   "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
#   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# sudo apt-get update
# sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Installing AWS-CLI
sudo apt-get install unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Installing Terraform
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install terraform

# Installing Kubectl
sudo apt update
sudo apt install curl -y
sudo curl -LO "https://dl.k8s.io/release/v1.28.4/bin/linux/amd64/kubectl"
sudo chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Installing Trivy
sudo apt-get install wget apt-transport-https gnupg lsb-release -y
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt update
sudo apt install trivy -y

# Run Docker Container of Sonarqube
docker run -d  --name sonar -p 9000:9000 sonarqube:lts-community

# # generate ssh key in jenkins
# sudo passwd jenkins [set jenkins pass]
# sudo su -jenkins
# ssh-keygen
# ssh -T git@github.com
# sudo su -root
# vi /etc/ssh/ssh_config
# -> UserKnownHostsFile /data/jenkins_home/.ssh/known_hosts
# -> IdentityFile /data/jenkins_home/.ssh/id_rsa


# sudo usermod -a -G docker jenkins

# sudo apt install maven
# sudo apt  install libxml2-utils



# sudo mkfs -t xfs /dev/nvme1n1
# sudo mkdir /data
# sudo mount /dev/nvme1n1 /data
# sudo cp /etc/fstab /etc/fstab.orig
# sudo blkid -s UUID -o value /dev/nvme1n1
# uuid=$(echo "UUID=replaceme  /data  xfs  defaults,nofail  0  2" | sed -e "s|replaceme|$(sudo blkid -s UUID -o value /dev/nvme1n1)|g")
# echo "$uuid" | sudo tee -a /etc/fstab

######change jenkins location#####
#sudo -i
# sudo service jenkins stop
# mkdir -p /data/jenkins_home
# sudo vim /lib/systemd/system/jenkins.service  ## change ENVIRONMENT="JENKINS_HOME=/data/jenkins_home" and Workingdirectory=/data/jenkins_home
# sudo vim /etc/passwd                          ## change the default /var/lib/jenkins to /data/jenkins_home
# mv  /var/lib/jenkins /data/jenkins_home
# chown -R jenkins:jenkins /data/jenkins_home
# sudo vim /etc/default/jenkins            ## change jenkins home location JENKINS_HOME=/data/jenkins_home
# cd /var/lib
# sudo rm -r jenkins
# #systemctl daemon-reload
# systemctl start jenkins


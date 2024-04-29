!/bin/bash
# Install Docker
sudo apt-get update
sudo apt-get install -y docker.io

# Install Portainer
sudo docker volume create portainer_data
sudo docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
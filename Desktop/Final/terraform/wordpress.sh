  #!/bin/bash

  # Install Docker
  sudo apt-get update
  sudo apt-get install -y docker.io
  # Install WordPress
    sudo docker volume create wordpress_data
    sudo docker run -d -p 8080:80 --name=wordpress --restart=always -v wordpress_data:/var/www/html -e WORDPRESS_DB_HOST=wordpress-db:3306 -e WORDPRESS_DB_NAME=wordpress -e WORDPRESS_DB_USER=admin -e WORDPRESS_DB_PASSWORD=password wordpress
  ```
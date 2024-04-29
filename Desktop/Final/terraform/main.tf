provider "aws" {
  region  = "us-east-1"  # Specify your desired AWS region here
}

resource "aws_instance" "portainer" {
  ami           = "ami-058bd2d568351da34"  # AMI for Debian 10 in us-east-1
  instance_type = "t2.medium"
  key_name      = "usethis"     # Specify your key pair name here

  user_data     = file("portainer.sh")     # User data script for startup
}

resource "aws_instance" "wordpress" {
  ami           = "ami-058bd2d568351da34"  # AMI for Debian 10 in us-east-1
  instance_type = "t2.medium"
  key_name      = "usethis"     # Specify your key pair name here

  user_data     = file("wordpress.sh")     # User data script for startup
}

resource "aws_instance" "ollama" {
  ami           = "ami-058bd2d568351da34"  # AMI for Debian 10 in us-east-1
  instance_type = "t2.medium"
  key_name      = "usethis"     # Specify your key pair name here

  user_data     = file("ollama.sh")        # User data script for startup
}
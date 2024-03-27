terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
    google = {
      source  = "hashicorp/google"
    }
    linode = {
      source  = "linode/linode"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

provider "google" {
  credentials = file(var.google_credentials_file)
  project     = "glass-hydra-412314"
  region      = "us-central1"
}

provider "linode" {
  token   = "d14f22b50c1cedfd98e9282e8a8ec293674871c329df7d5f07340d7a956b7440"
}

resource "aws_instance" "example" {
  ami           = "ami-07d9b9ddc6cd8dd30"
  instance_type = var.aws_machine_type
  key_name      = var.aws_key_name
  tags = {
    Name = var.instance_name
  }

  security_groups = [aws_security_group.ssh_access.name]

  user_data = <<-EOF
              #!/bin/bash
              useradd -m -s /bin/bash ubuntu
              EOF
}

resource "aws_security_group" "ssh_access" {
  name        = "ssh-access"
  description = "Allow SSH, HTTP, and HTTPS access"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"   # Represents all protocols
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  machine_type = var.gcp_machine_type
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  tags = ["allow-ssh"]

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}" // Replace with the path to your SSH public key
  }

  metadata_startup_script = <<-EOF
                            #!/bin/bash
                            useradd -m -s /bin/bash ubuntu
                            EOF
}

resource "google_compute_firewall" "allow_ssh_http_https" {
  name    = "allow-ssh-http-https"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "linode_instance" "example" {
  region          = "us-east"
  type            = "g6-nanode-1"
  label           = "example-instance"
  tags            = ["example-group"]
  image           = "linode/ubuntu20.04"
  authorized_keys = var.authorized_keys
}
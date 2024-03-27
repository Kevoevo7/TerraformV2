#!/bin/bash

# Read Terraform outputs for GCP, Azure, and AWS public IP addresses
GCP_PUBLIC_IP=$(terraform output gcp_public_ip)
LINODE_PUBLIC_IP=$(terraform output linode_public_ip | sed 's/"//g' | awk '{print $1}')
AWS_PUBLIC_IP=$(terraform output aws_public_ip)

echo "[Hosts]" > inventory.ini  # Truncate the file
# Write GCP public IP addresses to inventory
echo "$GCP_PUBLIC_IP  ansible_ssh_private_key_file=/home/administrator/.ssh/id_rsa" >> inventory.ini

# Write Azure public IP addresses to inventory
echo "$LINODE_PUBLIC_IP ansible_user=root ansible_ssh_private_key_file=/home/administrator/.ssh/id_rsa" >> inventory.ini

# Write AWS public IP addresses to inventory
echo "$AWS_PUBLIC_IP ansible_ssh_private_key_file=/home/administrator/Downloads/Ansiblekey.pem" >> inventory.ini
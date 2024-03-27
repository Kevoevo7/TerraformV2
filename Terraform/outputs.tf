output "aws_public_ip" {
  description = "Public IP addresses of AWS VMs"
  value = aws_instance.example.public_ip
}

output "aws_private_ip" {
  description = "Private IP addresses of AWS VMs"
  value = aws_instance.example.private_ip
}

output "gcp_public_ip" {
  description = "Public IP addresses of GCP VMs"
  value = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}

output "gcp_private_ip" {
  description = "Private IP addresses of GCP VMs"
  value = google_compute_instance.vm_instance.network_interface[0].network_ip
}

output "linode_public_ip" {
  description = "Public IP addresses of Linode VMs"
  value = linode_instance.example.ipv4
}

output "linode_private_ip" {
  description = "Private IP addresses of Linode VMs"
  value = linode_instance.example.ipv4
}
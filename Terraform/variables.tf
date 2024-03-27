variable "aws_access_key" {
  description = "AWS access key"
  sensitive = true
}

variable "aws_secret_key" {
  description = "AWS secret key"
  sensitive = true
}

variable "google_credentials_file" {
  description = "Path to the Google Cloud credentials file"
}

variable "aws_machine_type" {
  description = "Machine type for AWS EC2 instances"
  default     = "t2.micro"
}

variable "gcp_machine_type" {
  description = "Machine type for Google Compute Engine instances"
  default     = "e2-micro"
}

variable "aws_key_name" {
  description = "Name of the AWS key pair"
  default     = "Ansiblekey"
}

variable "instance_name" {
  description = "Name of the instance"
  default     = "example-instance"
}

variable "authorized_keys" {
  type    = list(string)
  # You can add other optional attributes such as description
  # description = "SSH public keys to be added to the Linode instance"
}

variable "linode_token" {
  description = "Linode API token"
}

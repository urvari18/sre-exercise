# Defined the provider AWS
provider "aws" {
  access_key = "YOUR_AWS_ACCESS_KEY"
  secret_key = "YOUR_AWS_SECRET_KEY"
  region     = "us-west-2"
}

# Created an EC2 instance for hosting the web application
resource "aws_instance" "web_server" {
  ami           = "ami-0c94855ba95c71c99"  # Enter the desired AMI ID here
  instance_type = "t2.micro"
  key_name      = "your-key-pair-name"  # Replace with your key pair name

  tags = {
    Name = "web-application-server"
  }

  # Provision the necessary dependencies for Node.js
  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update
    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    sudo apt-get install -y nodejs
  EOF
}

# Output the public IP address of the web server
output "web_server_ip" {
  value = aws_instance.web_server.public_ip
}

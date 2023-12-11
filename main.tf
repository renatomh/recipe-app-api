# Specify the provider (AWS)
provider "aws" {
  region = "us-east-2" # Update with your desired region
}

# Defining a security group to access the EC2 instance to be created
resource "aws_security_group" "security_group" {
  name        = "recipe-app-security-group"
  description = "Recipe App Security Group"

  # Allow SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Allow HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Allow HTTPS access from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule to allow all traffic to all destinations
  egress {
    from_port   = 0
    to_port     = 0    # Allow all ports
    protocol    = "-1" # Allow all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Defining variables for the EC2 instance user data
variable "user_password" {
  description = "User's password for the EC2 instance (write down this password, since it'll be the instance user's password)"
  type        = string
}
variable "ssh_public_key" {
  description = "SSH Public Key (formatted as: 'ssh-rsa PUBLIC_KEY_CONTENT', with no newlines) for the EC2 instance in order to access with the corresponding private key"
  type        = string
}

# Creating a new EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0e83be366243f524a" # Refers to Ubuntu Server 22.04 LTS (HVM), user data depends on it
  instance_type = "t3a.micro"             # You can replace this with your desired instance type

  # Defining the user data for the instance
  user_data = <<-EOF
    #!/bin/bash
    # Creating and setting up user
    useradd -m -s /bin/bash ec2-user
    echo "ec2-user:${var.user_password}" | chpasswd
    usermod -aG sudo ec2-user
    mkdir -p /home/ec2-user/.ssh
    echo "${var.ssh_public_key}" > /home/ec2-user/.ssh/authorized_keys
    chmod 700 /home/ec2-user/.ssh
    chmod 600 /home/ec2-user/.ssh/authorized_keys
    chown -R ec2-user:ec2-user /home/ec2-user/.ssh

    # Disable root login by editing the SSH configuration file
    sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
    # Configure SSH to disable password authentication
    sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
    sudo service ssh restart

    # Install Docker
    sudo apt update
    sudo apt -y install ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Isstall Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    # Install Make
    sudo apt -y install make

    # Cloning the GitHub repository and setting up
    cd /home/ec2-user/
    git clone https://github.com/renatomh/recipe-app-api.git
    cd recipe-app-api
    # !!! IMPORTANT: you should update the content from '.env' file after copying it
    cp .env.sample .env
    EOF

  # Adding the security group to the instance
  vpc_security_group_ids = [aws_security_group.security_group.id]
}

# provider
provider "aws" {
  # for this lab i want to do in Paris Region
  region = "eu-west-3"
}

# ssh key pair for ssh-access
resource "aws_key_pair" "lab_key" {
  key_name   = "tf-aws-lab-01"
  public_key = file("~/.ssh/tf-aws-lab-01.pub")
}

# Security Group allowing ssh
resource "aws_security_group" "ssh_access" {
  name        = "ssh-access"
  description = "Allow SSH"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Instance EC2
resource "aws_instance" "lab_instance" {
  # Amazon linux AMI Free Tier
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.lab_key.key_name
  vpc_security_group_ids = [aws_security_group.ssh_access.id] 
  associate_public_ip_address = true
  subnet_id = data.aws_subnet.public_subnet.id

  tags = {
    Name = "lab-01-instance"
  }

  # dependency
  depends_on = [aws_security_group.ssh_access] 
}

# AMI Data Sources
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  owners = ["amazon"]
}

# VPC and Subnet Data Sources 
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "public_subnet" {
  filter {
    name   = "default-for-az"
    values = ["true"]
  }

  filter {
    name   = "availability-zone"
    values = ["eu-west-3a"]
  }
}

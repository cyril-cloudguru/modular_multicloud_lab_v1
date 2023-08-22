terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}


# Create web VPC
resource "aws_vpc" "vpc1" {
  cidr_block = var.vpc1-cidr
}

resource "aws_internet_gateway" "gw1" {
  vpc_id = aws_vpc.vpc1.id

  depends_on = [
    aws_vpc.vpc1
  ]

  tags = {
    Name = var.vpc1-igw-name
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.vpc1-sub1-cidr

  depends_on = [
    aws_vpc.vpc1
  ]

  tags = {
    Name = var.vpc1-sub1-name
  }
}

resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw1.id
  }

}

resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rt1.id
}

resource "aws_network_interface" "nic1" {
  subnet_id       = aws_subnet.subnet1.id
  private_ips     = [var.vpc1-vm1-nic1-privip]
  security_groups = [aws_security_group.secgroup1.id]

  tags = {
    Name = var.vpc1-vm1-nic1-name
  }
}


# key pair 
resource "aws_key_pair" "key-pair1" {
key_name = var.sshkey1-name
public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
algorithm = "RSA"
rsa_bits  = 2048
}
resource "local_file" "key-pair1" {
content  = tls_private_key.rsa.private_key_pem
filename = "key-pair1"
}

resource "aws_instance" "vm1" {
  ami           = var.vpc1-vm1-ami
  instance_type = "t2.small"
  key_name               = var.sshkey1-name
  depends_on = [
    aws_vpc.vpc1,
    aws_subnet.subnet1,
    aws_network_interface.nic1,
    aws_key_pair.key-pair1 
  ]

  network_interface {
    network_interface_id = aws_network_interface.nic1.id
    device_index         = 0
  }

  tags = {
    name = var.vpc1-vm1-name
  }

  user_data = file("userdata_ms2022_iis.psl")
}

resource "aws_eip" "eip1" {
  tags = {
    Name = var.vpc1-vm1-nic1-eip1-name
  }
}

resource "aws_eip_association" "eip_assoc" {
  network_interface_id = aws_network_interface.nic1.id
  allocation_id = aws_eip.eip1.id
  depends_on = [
    aws_network_interface.nic1
  ]
}


resource "aws_security_group" "secgroup1" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.vpc1.id

  ingress {
    description = "HTTP from All"
    from_port   = 0
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "RDP from All"
    from_port   = 0
    to_port     = 3389
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}


# OUTPUT
output "aws_instance_public_dns" {
  value = aws_eip.eip1.public_dns
}
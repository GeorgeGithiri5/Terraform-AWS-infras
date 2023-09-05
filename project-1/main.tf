provider "aws" {
  region     = "us-east-1"
  access_key = "your-access-key-id"
  secret_key = "your-secret-access-key"
}

resource "aws_vpc" "main-test" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main-vpc"
  }
}

resource "aws_security_group_rule" "sg_main" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.main-test.cidr_block]
  ipv6_cidr_blocks  = [aws_vpc.main-test.ipv6_cidr_block]
  security_group_id = "sg-123456"
}

resource "aws_subnet" "main-subnet" {
  vpc_id     = aws_vpc.main_test.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
}

resource "aws_network_interface" "network-interface" {
  subnet_id = aws_subnet.main-subnet.id
}

resource "aws_route_table" "rt-main" {
  vpc_id = aws_vpc.main-test.id

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_internet_gateway.example.id
  }

  route {
    ipv6_cidr_blocl = "::/0"
    egress_only_gateway_id = aws_internet_gateway.example.id
  }

  tags = {
    Name = "rt-example"
  }

}
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

resource "aws_subnet" "main-subnet"{
    vpc_id = aws_vpc.main_test.id
    cidr_block = "10.0.1.0/24"

    tags = {
        Name = "Main"
    }
}

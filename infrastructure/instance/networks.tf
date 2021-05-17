resource "aws_vpc" "sand" {
  provider   = aws.master
  cidr_block = "10.0.0.0/16"
  tags = {
    name = "sand-iac-test"
  }
}

resource "aws_internet_gateway" "igw" {
  provider = aws.master
  vpc_id   = aws_vpc.sand.id
}

#Create route table 
resource "aws_route_table" "internet_route" {
  provider = aws.master
  vpc_id   = aws_vpc.sand.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  lifecycle {
    ignore_changes = all
  }
  tags = {
    Name = "IaC-RT"
  }
}

#Overwrite default route table with our route table entries
resource "aws_main_route_table_association" "set-master-default-rt-assoc" {
  provider       = aws.master
  vpc_id         = aws_vpc.sand.id
  route_table_id = aws_route_table.internet_route.id
}

data "aws_availability_zones" "azs" {
  provider = aws.master
  state    = "available"
}

resource "aws_subnet" "subneta" {
  provider          = aws.master
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id            = aws_vpc.sand.id
  cidr_block        = "10.0.1.0/24"
}

resource "aws_subnet" "subnetb" {
  provider          = aws.master
  availability_zone = element(data.aws_availability_zones.azs.names, 1)
  vpc_id            = aws_vpc.sand.id
  cidr_block        = "10.0.2.0/24"
}


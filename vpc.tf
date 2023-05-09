

resource "aws_vpc" "vpc" {
  cidr_block = var.VPC_CIDR

  tags = {
    Name = "${var.PREFIX}-vpc"
  }
}

resource "aws_subnet" "subnet" {
  count                   = length(var.SUBNET_CIDRS)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.SUBNET_CIDRS[count.index]
  availability_zone       = element(local.AVAILABILITY_ZONES, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.PREFIX}_subnet_${count.index}"
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

}

# create a route table for the public subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    Name = "${var.PREFIX}_PUBLIC_ROUTE"
  }

}

# associate the public route table with the public subnet
resource "aws_route_table_association" "public_route_table_association" {
  count          = length(var.SUBNET_CIDRS)
  subnet_id      = element(aws_subnet.subnet.*.id, count.index)
  route_table_id = aws_route_table.public_route_table.id

}

// sg 

resource "aws_security_group" "db_security_group" {
  name        = "${var.PREFIX}-db-security-group"
  description = "Security group for RDS database"

  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 3306 # Replace with the desired port for RDS MySQL
    to_port     = 3306 # Replace with the desired port for RDS MySQL
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Replace with the desired CIDR block for inbound traffic
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.PREFIX}-db-sg"
  }
}


// instance sg 

resource "aws_security_group" "ec2_security_group" {
  name        = "${var.PREFIX}-ec2-security-group"
  description = "Security group for ec2 instance"

  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.PREFIX}-ec2-sg"
  }
}




resource "aws_vpc" "vpc" {
  cidr_block = var.VPC_CIDR

  tags = {
    Name = "${var.PREFIX}-vpc"
  }
}

resource "aws_subnet" "subnet" {
  count             = length(var.SUBNET_CIDRS)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.SUBNET_CIDRS[count.index]
  availability_zone = element(local.AVAILABILITY_ZONES, count.index)
  tags = {
    Name = "${var.PREFIX}_subnet_${count.index}"
  }
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


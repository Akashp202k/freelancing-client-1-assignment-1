resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.PREFIX}-db-subnet-group"
  subnet_ids = [aws_subnet.subnet[0].id, aws_subnet.subnet[1].id]

  tags = {
    Name = "${var.PREFIX}-db-subnet-group"
  }
}

resource "aws_db_instance" "db_instance" {
  identifier           = "${var.PREFIX}-db-instance"
  engine               = "mysql"
  instance_class       = var.DB_INSTANCE_TYPE
  allocated_storage    = var.DB_ALLOCATED_STORAGE
  storage_type         = var.DB_STORAGE_TYPE
  username             = var.DB_USERNAME
  db_name              = var.DB_NAME
  password             = var.DB_PASSWORD
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name

  vpc_security_group_ids = [aws_security_group.db_security_group.id]

  tags = {
    Name = "${var.PREFIX}-db-instance"
  }
}

// creating key pair for ec2 instance 

resource "aws_key_pair" "ec2" {
  key_name   = var.KEY_NAME
  public_key = file(var.PUBLIC_KEY_PATH)
}

// Creating Ec2 for wordpress 

resource "aws_instance" "wordpress" {
  ami                    = var.EC2_AMI_ID
  instance_type          = var.EC2_INSTANCE_TYPE
  key_name               = var.KEY_NAME
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]

  user_data = file(var.USERDATA_FILE_PATH)

}


// connection between rds and wordpress running  docker container 

resource "null_resource" "configure_wordpress" {
  depends_on = [aws_instance.wordpress]

  connection {
    host        = aws_instance.wordpress.public_ip
    type        = "ssh"
    user        = "ubuntu"                   # Update with your desired SSH user
    private_key = file(var.PRIVATE_KEY_PATH) # Replace with the path to your private key
  }

  provisioner "remote-exec" {
    inline = [file("scripts/connector")]
  }
}

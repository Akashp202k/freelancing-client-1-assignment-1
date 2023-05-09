REGION       = "us-east-1"
PREFIX       = "devops-assign"
VPC_CIDR     = "10.0.0.0/16"
SUBNET_CIDRS = ["10.0.1.0/24", "10.0.2.0/24"]
AZ_PREFIX    = ["a", "b", "c"]

// db vars 

DB_INSTANCE_TYPE     = "db.t3.micro"
DB_ALLOCATED_STORAGE = "20"
DB_STORAGE_TYPE      = "gp2"
DB_NAME              = "wordpress_db"
DB_USERNAME          = "akash"
DB_PASSWORD          = "Akash202k"


// ec2 vars 


USERDATA_FILE_PATH = "scripts/ec2-wordpress-userdata.sh"
KEY_NAME           = "wordpress"
PUBLIC_KEY_PATH    = "~/.ssh/akash.pub"
EC2_AMI_ID         = "ami-007855ac798b5175e"
EC2_INSTANCE_TYPE  = "t2.small"

PRIVATE_KEY_PATH = "~/.ssh/akash"


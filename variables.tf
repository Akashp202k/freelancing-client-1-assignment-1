variable "REGION" { type = string }
variable "PREFIX" { type = string }
variable "VPC_CIDR" { type = string }
variable "SUBNET_CIDRS" { type = list(string) }

locals {
  AZ_SUFFIXES        = ["a", "b", "c"]
  AVAILABILITY_ZONES = [for suffix in local.AZ_SUFFIXES : "${var.REGION}${suffix}"]
}

// db vars 

variable "DB_INSTANCE_TYPE" { type = string }
variable "DB_ALLOCATED_STORAGE" { type = string }
variable "DB_STORAGE_TYPE" { type = string }
variable "DB_NAME" { type = string }
variable "DB_USERNAME" { type = string }
variable "DB_PASSWORD" { type = string }

// ec2 vars 

variable "USERDATA_FILE_PATH" { type = string }
variable "KEY_NAME" { type = string }
variable "PUBLIC_KEY_PATH" { type = string }
variable "EC2_AMI_ID" { type = string }
variable "EC2_INSTANCE_TYPE" { type = string }

// connecting rds and wordpress 

variable "PRIVATE_KEY_PATH" { type = string }
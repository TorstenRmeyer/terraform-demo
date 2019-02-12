provider "aws" {
  region = "eu-central-1"
}


terraform {
	backend "s3" {
		## Config not used here - parameters are provided as key-value pairs in init
		## during terraform init
		# bucket = "s3-terraform-state"
		# key = "my-project"
		# region = "eu-central-1"
	}
}

##################################################################
# Example: Show how to read data from AWS
# Data sources to get VPC, subnet, security group and AMI details
##################################################################
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = "${data.aws_vpc.default.id}"
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

##################################################################
# Example: Create a simple SNS - use Variable for name
##################################################################
resource "aws_sns" "example_sns" {
	name= "${vars.snstopic}"
}


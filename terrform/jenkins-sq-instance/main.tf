provider "aws" {
  region = var.region
}

module "lib" {
  source = "../lib/"
  # name = var.name
}

terraform {
  backend "s3" {
    bucket = "chirag-ptel-bucket-for-tf-state"
    key    = "jenkins-ec2/terraform.tfstate"
    dynamodb_table = "dynamodb-statelock-for-tfstate-bucket"
    region = "ap-south-1"
  }
} 

resource "aws_instance" "ec2" {
  ami                    = "ami-0f5ee92e2d63afc18"
  instance_type          = "c5n.xlarge"
  key_name               = "chirag-admin-ec2-kp"
  subnet_id              = element(module.lib.public_subnets, 0)
  vpc_security_group_ids = [aws_security_group.jenkins-ec2-sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_jenkins_instance_iam_profile.name
  root_block_device {
    volume_size = 30
  }
  user_data = templatefile("./ec2-userdata.sh", {})

  tags = {
    Name = "jenkins-ec2-instance"
  }
}

resource "aws_iam_role" "role_ec2_jenkins" {
  name = "${var.name}-ec2-jenkins-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    { 
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_instance_profile" "ec2_jenkins_instance_iam_profile" {
  name = "ec2_jenkins_instance_profile"
  role = aws_iam_role.role_ec2_jenkins.name
}

resource "aws_iam_role_policy_attachment" "ec2_jenkins_policy" {
  role       = "${aws_iam_role.role_ec2_jenkins.name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess" # Just for testing purpose, not advisible to give administrator access
}



# add known hosts for github to ssh by below commands

# ssh -T git@github.com

# vim ~/.ssh/config

# add IgnoreUnknown UseKeychain in config file


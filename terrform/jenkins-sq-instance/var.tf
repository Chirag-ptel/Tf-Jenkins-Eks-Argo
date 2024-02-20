variable "name" {
  type = string
  description = "The name prefix for the resource."
  default = "ec2-jenkins"
}

variable "region" {
  description = "The AWS region in which to create the VPC"
  default = "ap-south-1"
}
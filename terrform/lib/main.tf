data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "chirag-ptel-bucket-for-tf-state"
    key    = "vpc/terraform.tfstate"
    region = "ap-south-1"
  }
}


 output "vpc_id" {
  value = data.terraform_remote_state.vpc.outputs.vpc_id
 }

 output "vpc_cidr_block" {
    value = data.terraform_remote_state.vpc.outputs.vpc_cidr_block
 }

 output "default_security_group_id" {
    value = data.terraform_remote_state.vpc.outputs.default_security_group_id
 }

 output "public_subnets" {
    value = data.terraform_remote_state.vpc.outputs.public_subnets
 }

 output "private_subnets" {
    value = data.terraform_remote_state.vpc.outputs.private_subnets
 }


## Infrastructure Provisioning for Dev Environment 

Configuration in this directory creates set of VPC resources which may be sufficient for **prod** environment.

It will create public private subnets, NAT Gateways, Internet Gateways and EC2 Instance in Public subnet.

## Usage

To run this example you need to execute:

```
$ terraform init
$ terraform plan
$ terraform apply

```
**Note** that this example may create resources which can cost money (AWS Elastic IP, for example). Run **terraform destroy** when you don't need these resources.

## Sample Template

```hcl

## This Template creates the infrastructure
## with bastion host
##

module "main-vpc" {
  source     = "../../modules/vpc"
  ENV        = "${var.ENV}"                    #productEnv
  AWS_REGION = "${var.AWS_REGION}"
  VPC_NAME   = "${var.VPC_NAME}"               #productID
  az1        = "${var.AWS_REGION}a"
  az2        = "${var.AWS_REGION}b"
}

module "bastion" {
  source         = "../../modules/bastion"
  ENV            = "${var.ENV}"
  AWS_REGION     = "${var.AWS_REGION}"
  VPC_NAME       = "${var.VPC_NAME}"                     #productID
  vpc_id         = "${module.main-vpc.vpc_id}"           #productVPC
  public_subnets = "${module.main-vpc.public_subnets-1}"
  keyname        = "bastion-key"                         #Key name
  pubkey         = "ssh-rsa xxxxxxxxxxxxxxxxxxxxxxx"     #public key
}

```

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | VPC ID |
| public_subnets-1 | ID of public subnet 1 |
| public_subnets-2 | ID of public subnet 2 |
| private_subnets-1 | ID of private subnet 1 |
| private_subnets-2 | ID of private subnet 2 |
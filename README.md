Terraform module which creates VPC resources and EC2 on AWS.

These types of resources are supported:

* [VPC](https://www.terraform.io/docs/providers/aws/r/vpc.html)
* [Subnet](https://www.terraform.io/docs/providers/aws/r/subnet.html)
* [Route](https://www.terraform.io/docs/providers/aws/r/route.html)
* [Route table](https://www.terraform.io/docs/providers/aws/r/route_table.html)
* [Internet Gateway](https://www.terraform.io/docs/providers/aws/r/internet_gateway.html)
* [NAT Gateway](https://www.terraform.io/docs/providers/aws/r/nat_gateway.html)
* [Bastion Host](https://www.terraform.io/docs/providers/aws/r/instance.html)

## VPC
By default this modules creates the **VPC** with **two public subnets** and **two private subnets** with **NAT gateways on each Private subnets**.
**Internet Gateway** is associated with public Subnets.

```hcl

module "main-vpc" {
  source     = "https://github.com/karan6190/terraform-aws-infra/tree/master/modules/vpc"
  ENV        = "${var.ENV}"                  #productEnv
  AWS_REGION = "${var.AWS_REGION}"
  VPC_NAME   = "${var.VPC_NAME}"             #productID
  az1        = "${var.AWS_REGION}a"
  az2        = "${var.AWS_REGION}b"
}

```
## Bastion Host
Bastion host helps us to Jump into the Instances in the private subnets.
So this module launches the Instance in the public subnet which act as a jump server.
By default Bastion host is launched with attached **Administrative access policy** and **Security group (to access it over SSH)**

```hcl
module "bastion" {
  source         = "https://github.com/karan6190/terraform-aws-infra/tree/master/modules/bastion"
  ENV            = "${var.ENV}"
  AWS_REGION     = "${var.AWS_REGION}"
  VPC_NAME       = "${var.VPC_NAME}"                     #productID
  vpc_id         = "${module.main-vpc.vpc_id}"           #productVPC
  public_subnets = "${module.main-vpc.public_subnets-1}"
  pubkey         = "ssh-rsa xxxxxxxxxxxxxxxxxxxxxxx"     #public key
}

```

## Examples

* [Infrastructure for dev Environment](https://github.com/karan6190/terraform-aws-infra/tree/master/examples/infra-dev)
* [Infrastructure for prod Environment](https://github.com/karan6190/terraform-aws-infra/tree/master/examples/infra-prod)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| ENV | Infrastructure Environment | String | dev | no |
| VPC_NAME | Infrastructure Name | String | Demo-dev | no |
| pubkey | Key which is to associate with bastion host | String | " " | yes

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | VPC ID |
| public_subnets-1 | ID of public subnet 1 |
| public_subnets-2 | ID of public subnet 2 |
| private_subnets-1 | ID of private subnet 1 |
| private_subnets-2 | ID of private subnet 2 |

## Architecture

![terraform-aws-infra](https://github.com/karan6190/terraform-aws-infra/blob/v1.0.2/docs/terraform-aws-infra.JPG)


## Authors

Module is maintained by [Karan Sharma](https://github.com/karan6190).

## License

Apache 2 Licensed. See LICENSE for full details.



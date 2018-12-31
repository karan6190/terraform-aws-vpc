variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  default = "us-east-2"
}

variable "VPC_NAME" {
  default = "Demo-prod"
}

variable "ENV" {
  default = "prod"
}

variable "amis" {
  type = "map"
  default = {
    us-east-1 = "ami-0947d2ba12ee1ff75"
    us-west-1 = "ami-0e4035ae3f70c400f"
  }
}

variable "region" {
  default="us-east-1"
}

variable "total_instances" {
  default=1
}

variable "aws_access_key" {}
variable "aws_secret_key" {}

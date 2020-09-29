provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-east-2"
}

variable "zones" {
  default = ["us-east-2a", "us-east-2b"]
}

resource "aws_instance" "example" {
  count                 = 2
  availability_zone     = var.zones[count.index]
  ami                   = "ami-03657b56516ab7912"
  instance_type         = "t2.micro"
}

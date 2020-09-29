provider "aws" {
#  access_key = "Access Key"
#  secret_key = "Secrey Key"
  region     = "us-east-2"
}
resource "aws_instance" "example" {
  ami           = "ami-03657b56516ab7912"
  instance_type = "t2.micro"
}

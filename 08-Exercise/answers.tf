provider "aws" {
#  access_key = "ACCESS_KEY"
#  secret_key = "SECRET_KEY"
  region     = "us-east-1"
}

provider "aws" {
  alias      = "us-west-1"
 # access_key = "ACCESS_KEY"
 # secret_key = "SECRET_KEY"
  region     = "us-west-1"
}

variable "us-east-zones" {
  default = ["us-east-1a", "us-east-1b"]
}

variable "us-west-zones" {
  default = ["us-west-1a", "us-west-1c"]
}

resource "aws_instance" "west_frontend" {
  count             = 2
  depends_on        = [aws_instance.west_backend]
  provider          = aws.us-west-1
  ami               = "ami-0e4035ae3f70c400f"
  availability_zone = var.us-west-zones[count.index]
  instance_type     = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "frontend" {
  count             = 2
  depends_on        = [aws_instance.backend]
  availability_zone = var.us-east-zones[count.index]
  ami               = "ami-0947d2ba12ee1ff75"
  instance_type     = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "backend" {
  count             = 2
  availability_zone = var.us-east-zones[count.index]
  ami               = "ami-0947d2ba12ee1ff75"
  instance_type     = "t2.micro"

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_instance" "west_backend" {
  provider          =  aws.us-west-1
  ami               =  "ami-0e4035ae3f70c400f"
  count             =  2
  availability_zone =  var.us-west-zones[count.index]
  instance_type     =  "t2.micro"

  lifecycle {
    prevent_destroy = false
  }
}

output "frontend_ip" {
  value = aws_instance.frontend.*.public_ip
}

output "backend_ips" {
  value = aws_instance.backend.*.public_ip
}

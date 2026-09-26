
provider "aws" {
  region = "us-east-1"

}
resource "aws_instance" "smallec2" {
  ami                    = "ami-0fef201115eefe936"
  instance_type          = "t3.micro"
  key_name               = "key"
  vpc_security_group_ids = ["sg-0243b2a705e92d42b"]

  tags = {
    Name        = "Linux"
    name        = "anand"
    environment = "dev"
  }
}


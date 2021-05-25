provider "aws" {
 region = "us-east-1"
}

resource "aws_instance" "ec2" {
  ami = "ami-0742b4e673072066f"
  instance_type = "t2.micro"
  key_name = "jayterraform"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

}


resource "aws_security_group" "allow_tls" {
  name = "allow_tls"
  vpc_id = "vpc-1a78cc67"
ingress {
    description      = "ssh to ec2"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

provider "aws" {
 region = "us-east-1"
}

data "aws_availability_zones" "all" {
  state = "available"
}

resource "aws_instance" "ec2" {
  ami = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  key_name = "jaywebserver"
  vpc_security_group_ids = [aws_security_group.webserver.id]

user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
}


resource "aws_security_group" "webserver" {
  name = "webserver"
  vpc_id = "vpc-1a78cc67" 
ingress {
    
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]

  }
  ingress {
    from_port        = 8080
    to_port          = 8080
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
}
  
  
resource "aws_elb" "loadbalancer" {
    name = "terraform-asg"
    security_groups = [aws_security_group.elb.id]
    availability_zones = data.aws_availability_zones.all.names

health_check {
    target              = "HTTP:${var.server_port}/"
    interval            = 30
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

listener {
      lb_port = 80
      lb_protocol ="http"
      instance_port = var.server_port
      instance_protocol = "http"
    }
  }

resource "aws_security_group" "elb" {
    name = "terraform-elb"

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_configuration" "launchconf" {
  image_id      = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"

lifecycle {
    create_before_destroy = true
  }

}
  
resource "aws_autoscaling_group" "autoscaling" {
  launch_configuration = aws_launch_configuration.launchconf.id
  availability_zones   = data.aws_availability_zones.all.names

  min_size = 2
  max_size = 10

  load_balancers    = [aws_elb.loadbalancer.name]
  health_check_type = "ELB"

  tag {
    key                 = "name"
    value               = "autoscaling-example"
    propagate_at_launch = true
  }


}

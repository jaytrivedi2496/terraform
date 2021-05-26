provider "aws" {
  region = "us-east-1"
}
module "loadbalancer" {
  source = "https://github.com/jaytrivedi2496/modules.git//loadbalancer?ref=v2.0"

  server_port = 8080

  loadbalancer_name = "loadbalancer-stage"

  instance_type = "t2.micro"

  min_size = 2
  
  max_size = 2
}
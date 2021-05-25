provider "aws" {
  region = "us-east-1"
}
module "loadbalancer" {
  source = "../../../modules1/services/loadbalancer"

  server_port = 8080

  loadbalancer_name = "loadbalancer-stage"
  instance_type = "t2.micro"
  min_size = 2
  max_size = 2
}
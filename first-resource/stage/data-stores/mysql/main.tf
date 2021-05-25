provider "aws" {
  region = "us-east-1"  
}

terraform {
  backend "s3" {
      bucket = "jaystatefiles2496"
      key = "stage/data-stores/mysql/terraform.tfstate"
      region = "us-east-1"

      dynamodb_table = "jaystatefiles"
      encrypt = true
  }
}
resource "aws_db_instance" "datasource" {
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = "mydbinstance"
  username            = "admin"
  password            = "jayjay2496"
  skip_final_snapshot  = true
}
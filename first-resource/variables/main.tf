
provider "aws" {
access_key = "AKIAYNEITYL47QIO5QEX"
secret_key = "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"
 region = "us-east-1"
}


variable "vpcname" {
    type = string
    default = "myvpc"
  
}

variable "sshport" {
    type = number
    default = 22
  
}

variable "enabled" {
    default = true

}
variable "mylist" {
    type = list(string)
    default = ["value1", "value2"]

}
variable "mymap" {
    type = map
    default = {
        key1 = "value1"
        key2 = "value2"
    }
}

variable "inputname" {
    type = string
    description = "Set the name of the VPC"
  
}

resource "aws_vpc" "myvpc" {

    cidr_block = "10.0.0.0/16"

    tags = {
      Name = var.inputname
    }
  
}

output "vpcid" {

    value = aws_vpc.myvpc.id
  
}
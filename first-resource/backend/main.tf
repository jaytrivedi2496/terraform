provider "aws" {
access_key = "AKIAYNEITYL47QIO5QEX"
secret_key = "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"
 region = "us-east-1"
}

resource "aws_vpc" "test" {
  cidr_block = "10.0.0.0/16"
}
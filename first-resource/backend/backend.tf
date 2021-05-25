terraform {
  backend "s3" {
    key = "terraform/tfstate.tfstate"  
    bucket = "jay-remote-backend"
    access_key = "AKIAYNEITYL47QIO5QEX"
    secret_key = "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"
    region = "us-east-1"
  }
}
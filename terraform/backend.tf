terraform {
  backend "s3" {
    bucket = "blin-terraform-state"
    key    = "packing_list"
    region = "us-east-1"
  }
}

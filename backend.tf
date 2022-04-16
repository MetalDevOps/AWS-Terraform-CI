terraform {
    backend "s3" {
        region = "us-east-1"
        bucket = "kyoninja-bucket"
        encrypt = "true"
        key = "terraform.tfstate"
    }
}
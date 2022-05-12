
provider "aws" {
    region = "us-east-1"
    access_key = ""
    secret_key = ""
}

provider "aws" {
    alias = "central"
    region = "us-west-1"
    access_key = ""
    secret_key = ""
}

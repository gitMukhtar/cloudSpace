variable "AWS_ACCESS_KEY" {
  default = "AKIAUHEYETQIG3A6IHUZ"
}

variable "AWS_SECRET_KEY" {
  default = "RYSbeBqAnW4/wlsOrz3yhxSo+XAKkx7mSf8yMJAr"

}

variable "AWS_REGION" {
  default = "us-east-2"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-2 = "ami-0e38b48473ea57778"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-0d729a60"
  }
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

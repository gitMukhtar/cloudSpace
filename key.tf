resource "aws_key_pair" "mykeypair" {
  key_name   = "mykey"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

variable "AWS_ACCESS_KEY" {
  default = "AKIAXSWBQQFDOQFM6JHD"
}

variable "AWS_SECRET_KEY" {
  default = "MliUlL/c/zgCbV3IRTz5draj1OYTUTPmIOTocsaR"

}

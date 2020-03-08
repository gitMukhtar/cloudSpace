resource "aws_key_pair" "mykeypair" {
  key_name   = "mykey"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

variable "AWS_ACCESS_KEY" {
  default = "AKIAXSWBQQFDAIXJ5DT7"
}

variable "AWS_SECRET_KEY" {
  default = "F/oEc6KTOsoAU54X5OV4W6OM0uIBqEzqRZZlE6OP"

}

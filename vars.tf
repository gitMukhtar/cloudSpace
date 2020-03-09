
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
variable "PATH_TO_PRIVATE_KEY"{
 default = "/Users/alfia/Desktop/cloudSpace/mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "/Users/alfia/Desktop/cloudSpace/mykey.pub"
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "tenancy" {
  default = "default"
}
variable "enable_dns_support" {
  default = "true"
}
variable "enable_dns_hostnames" {
  default = "true"
}
variable "enable_classiclink" {
  default = "false"
}

# SUBNET LEVEL

variable "pub_subnet_1_cidr" {
  default = "10.0.1.0/24"
}
variable "pub_subnet_2_cidr" {
  default = "10.0.2.0/24"
}

variable "map_pub_ip_on_launch_true" {
  default = "true"
}
variable "map_pub_ip_on_launch_false" {
  default = "false"
}

variable "az_a" {
  default = "us-east-2a"
}
variable "az_b" {
  default = "us-east-2b"
}

# Route Table Cidr
variable "route_table_cidr" {
  default = "0.0.0.0/0"
}

variable "cidr_for_allow_access" {
  default = "0.0.0.0/0"
}

# Auto Scaling Properties:

variable "ins_min_size" {
  default = "2"
}
variable "ins_max_size" {
  default = "2"
}
variable "hltchk_grace_period" {
  default = "300"
}
variable "user_data_file" {
  default  = "${file("userdata.sh")}}"
}


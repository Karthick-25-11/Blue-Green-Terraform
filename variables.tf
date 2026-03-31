variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "blue_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "green_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "availability_zone_blue" {
  default = "us-east-1a"
}

variable "availability_zone_green" {
  default = "us-east-1b"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "ami_id" {
  default = "ami-0ec10929233384c7f"
}

variable "key_name" {
  default = "dd-key"
}

# For traffic switching
variable "active_env" {
  default = "blue"
}
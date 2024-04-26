variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "private_app_subnet" {
  type = list(string)
}

variable "public_web_subnet" {
  type = list(string)
}
variable "private_db_subnet" {
  type = list(string)
}
variable "availability_zone" {
  type = list(string)
}

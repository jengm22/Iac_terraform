variable "profile" {
  default = "default"
}

variable "region" {
  default = "eu-west-2"
}

variable "vpc" {
  default = "sand"
}

variable "master-count" {
  type    = number
  default = 2
}

variable "instance-type" {
  type    = string
  default = "t2.micro"
}

variable "webserver-port" {
  type    = number
  default = 80
}

variable "created_by" {
  default = "mahtarr_jeng"
}
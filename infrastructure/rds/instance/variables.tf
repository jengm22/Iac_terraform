

variable "region" {
  default = "eu-west-2"
}

variable "instance-class" {
  type    = string
  default = "db.t3.micro"
}

variable "name" {
  type    = string
  default = "mahtarrsDB"
}

variable "engine-version" {
  type    = string
  default = "5.7"
}

variable "vpc" {
  default = "sand"
}

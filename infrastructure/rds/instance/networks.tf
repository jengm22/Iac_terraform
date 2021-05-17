// // data "aws_vpc" "sand" {
// //   tags = {
// //     name = "sand-iac-test"
// //   }
// // }

// resource "aws_vpc" "sand" {
//   cidr_block = "10.0.0.0/16"
//   tags = {
//     name = "sand-iac-test"
//   }
// }

// data "aws_availability_zones" "azs" {
//   state = "available"
// }

// resource "aws_subnet" "subnetb" {
//   availability_zone = element(data.aws_availability_zones.azs.names, 1)
//   vpc_id            = aws_vpc.sand.id
//   cidr_block        = "10.0.2.0/24"
// }

// data "aws_db_subnet_group" "rds_subnetb" {
//   name       = "rds-main"
//   subnet_ids = [aws_subnet.subnetb.id]
// }

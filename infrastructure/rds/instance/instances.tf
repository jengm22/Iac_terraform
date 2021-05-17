resource "aws_db_instance" "mydb" {
  allocated_storage = 10
  engine            = "mysql"
  identifier        = "mahtarrs-db"
  engine_version    = var.engine-version
  instance_class    = var.instance-class
  // db_subnet_group_name = data.aws_db_subnet_group.rds_subnetb
  name                = var.name
  username            = "admin"
  password            = "secret123"
  skip_final_snapshot = true
  tags = {
    Owner       = "mahtarrjeng"
    Environment = "test"
  }
}
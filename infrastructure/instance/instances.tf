#Get Linux AMI ID using SSM Parameter endpoint in eu-west-2
data "aws_ssm_parameter" "linuxAmi" {
  provider = aws.master
  name     = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

#Create key-pair for logging into EC2 
resource "aws_key_pair" "master-key" {
  provider   = aws.master
  key_name   = "terraform-iac"
  public_key = file("../../id_rsa.pub")
}

#Create and bootstrap EC2 in eu-west-2
resource "aws_instance" "mahtarrs-master" {
  provider                    = aws.master
  ami                         = data.aws_ssm_parameter.linuxAmi.value
  count                       = var.master-count
  instance_type               = var.instance-type
  key_name                    = "terraform-iac"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.iac-test-sg.id]
  subnet_id                   = aws_subnet.subneta.id

  tags = {
    Name = join("_", ["mahtarrs_master_tf", count.index + 1])
  }

  user_data = data.template_cloudinit_config.cloudinit_user_data.rendered

}
#Get Linux AMI ID using SSM Parameter endpoint in eu-west-2
data "aws_ssm_parameter" "linuxAmi" {
  provider = aws.master
  name     = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

#Create key-pair for logging into EC2 
resource "aws_key_pair" "master-key" {
  provider   = aws.master
  key_name   = "terraform-iac"
  public_key = file("~/.ssh/id_rsa.pub")
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


  #The code below is ONLY the provisioner block which needs to be
  #inserted inside the resource block

  provisioner "local-exec" {
    command = <<EOF
aws --profile ${var.profile} ec2 wait instance-status-ok --region ${var.region} --instance-ids ${self.id}
ansible-playbook --extra-vars 'passed_in_hosts=tag_Name_${self.tags.Name}' ansible_templates/install_apache.yml
EOF
  }

}


output "Iac-Public-IPs" {
  value = {
    for instance in aws_instance.mahtarrs-master :
    instance.id => instance.public_ip
  }
}

#Add LB DNS name to outputs.tf
output "LB-DNS-NAME" {
  value = aws_lb.iac-lb.dns_name
}
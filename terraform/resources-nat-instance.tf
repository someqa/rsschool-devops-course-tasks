resource "aws_instance" "nat_instance" {
  ami                         = "ami-097c5c21a18dc59ea" 
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public[0].id
  associate_public_ip_address = true
  source_dest_check           = false

  tags = {
    Name = "NAT-Instance"
  }

  user_data = <<-EOF
  #!/bin/bash
  yum update -y
  yum install -y iptables-services
  echo 1 > /proc/sys/net/ipv4/ip_forward
  iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
  systemctl enable iptables
  EOF
}

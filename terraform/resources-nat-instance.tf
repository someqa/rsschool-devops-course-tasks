resource "aws_instance" "nat_instance" {
  ami                         = "ami-097c5c21a18dc59ea"
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public[0].id
  associate_public_ip_address = true
  source_dest_check           = false

  key_name                = aws_key_pair.someqa-key.key_name
  disable_api_termination = true

  tags = {
    Name = "NAT-Instance"
  }

  user_data = <<-EOF
#!/bin/bash
# Install required packages
yum update -y
yum install -y iptables-services

# Enable IP forwarding
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p

# Configure iptables for NAT
iptables -F FORWARD
iptables -t nat -A POSTROUTING -o ens5 -j MASQUERADE
iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i ens5 -o ens5 -j ACCEPT
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables-save | tee /etc/sysconfig/iptables

# Enable and start iptables service
systemctl enable iptables
systemctl start iptables

# Save iptables rules
service iptables save

EOF

}

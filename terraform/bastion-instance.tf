resource "aws_instance" "bastion" {
  ami                    = "ami-097c5c21a18dc59ea"  
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public[0].id
  security_groups        = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true
  key_name               = aws_key_pair.someqa-key.key_name  

  tags = {
    Name = "bastion-host"
  }
}

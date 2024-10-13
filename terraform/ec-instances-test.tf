resource "aws_key_pair" "someqa-key" {
  key_name   = "someqa-key"
  public_key = file("~/.ssh/someqa-key.pub")
}


resource "aws_instance" "test_instance_public_subnet_1" {
  ami           = "ami-097c5c21a18dc59ea" 
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public[0].id
  security_groups = [aws_security_group.test_sg.id]
    key_name      = aws_key_pair.someqa-key.key_name
  tags = {
    Name = "Test-Instance-Public-Subnet-1"
  }
}

resource "aws_instance" "test_instance_public_subnet_2" {
  ami           = "ami-097c5c21a18dc59ea" 
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public[1].id
  security_groups = [aws_security_group.test_sg.id]
    key_name      = aws_key_pair.someqa-key.key_name
  tags = {
    Name = "Test-Instance-Public-Subnet-2"
  }
}

resource "aws_instance" "test_instance_private_subnet_1" {
  ami           = "ami-097c5c21a18dc59ea"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.private[0].id
  security_groups = [aws_security_group.test_sg.id]

  tags = {
    Name = "Test-Instance-Private-Subnet-1"
  }
}

resource "aws_instance" "test_instance_private_subnet_2" {
  ami           = "ami-097c5c21a18dc59ea"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.private[1].id
  security_groups = [aws_security_group.test_sg.id]

  tags = {
    Name = "Test-Instance-Private-Subnet-2"
  }
}

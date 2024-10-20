resource "aws_security_group" "nat_sg" {
  vpc_id = aws_vpc.k8s_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all inbound traffic from private subnets
    cidr_blocks = ["10.0.0.0/16"]  # Adjust according to your private subnet CIDR
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic to the internet
    cidr_blocks = ["0.0.0.0/0"]  # Allow outbound to the internet
  }
}

// Attach the NAT instance security group
resource "aws_network_interface_sg_attachment" "nat_sg_attachment" {
  security_group_id    = aws_security_group.nat_sg.id
  network_interface_id = aws_instance.nat_instance.primary_network_interface_id
}

// security group for ec2 instances for testing
resource "aws_security_group" "test_sg" {
  vpc_id = aws_vpc.k8s_vpc.id

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]  
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "bastion_sg" {
  vpc_id = aws_vpc.k8s_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-sg"
  }
}

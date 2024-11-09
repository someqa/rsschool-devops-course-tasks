resource "aws_key_pair" "someqa-key" {
  key_name   = "someqa-key"
  public_key = file("~/.ssh/someqa-key.pub")
}


# resource "aws_instance" "test_instance_public_subnet_1" {
#   ami             = "ami-097c5c21a18dc59ea"
#   instance_type   = "t3.micro"
#   subnet_id       = aws_subnet.public[0].id
#   security_groups = [aws_security_group.test_sg.id]
#   key_name        = aws_key_pair.someqa-key.key_name
#   tags = {
#     Name = "Test-Instance-Public-Subnet-1"
#   }
# }

# resource "aws_instance" "test_instance_public_subnet_2" {
#   ami             = "ami-097c5c21a18dc59ea"
#   instance_type   = "t3.micro"
#   subnet_id       = aws_subnet.public[1].id
#   security_groups = [aws_security_group.test_sg.id]
#   key_name        = aws_key_pair.someqa-key.key_name
#   tags = {
#     Name = "Test-Instance-Public-Subnet-2"
#   }
# }

resource "aws_instance" "k3s_master" {
  depends_on      = [aws_instance.nat_instance]
  ami             = "ami-097c5c21a18dc59ea"
  instance_type   = "t3.small"
  subnet_id       = aws_subnet.private[0].id
  security_groups = [aws_security_group.k3s_sg.id]
  key_name        = aws_key_pair.someqa-key.key_name
  tags = {
    Name = "k3s_master"
  }
  #   master node
  user_data = <<-EOF
    #!/bin/bash
    curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode "644" --token ${var.k3s_token} --kube-apiserver-arg "bind-address=0.0.0.0"
    TOKEN=$(cat /var/lib/rancher/k3s/server/node-token)
    MASTER_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

    echo $TOKEN > /var/lib/rancher/k3s/server/token
    echo $MASTER_IP > /var/lib/rancher/k3s/server/ip

    
    kubectl create namespace jenkins-namespace
    kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.6.0/deploy/longhorn.yaml 
    
  EOF
}

resource "aws_instance" "k3s_worker" {
  depends_on      = [aws_instance.k3s_master]
  ami             = "ami-097c5c21a18dc59ea"
  instance_type   = "t3.small"
  subnet_id       = aws_subnet.private[1].id
  security_groups = [aws_security_group.k3s_sg.id]
  key_name        = aws_key_pair.someqa-key.key_name
  tags = {
    Name = "k3s_worker"
  }
  #worker node
  user_data = <<-EOF
        #!/bin/bash
        curl -sfL https://get.k3s.io | K3S_URL=https://${aws_instance.k3s_master.private_ip}:6443 K3S_TOKEN=${var.k3s_token} sh -
      EOF
}

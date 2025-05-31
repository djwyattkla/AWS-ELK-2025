# Terraform to deploy Kali, Ubuntu Victim (DVWA), and ELK Stack in us-east-1

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "elk_lab_sg" {
  name        = "elk-lab-sg"
  description = "Allow SSH, HTTP, Kibana"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Kibana"
    from_port   = 5601
    to_port     = 5601
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

# Kali Linux (t3.medium)
resource "aws_instance" "kali" {
  ami                         = "ami-0cf57d4e3b64b608b"
  instance_type               = "t3.medium"
  key_name                    = "kali-key-east"
  vpc_security_group_ids      = [aws_security_group.elk_lab_sg.id]
  associate_public_ip_address = true
  tags = { Name = "kali-attacker" }
}

# Ubuntu Victim with DVWA (t2.micro)
resource "aws_instance" "victim" {
  ami                         = "ami-0c7217cdde317cfec"
  instance_type               = "t2.micro"
  key_name                    = "kali-key-east"
  vpc_security_group_ids      = [aws_security_group.elk_lab_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y apache2 mariadb-server php php-mysqli git
              git clone https://github.com/digininja/DVWA /var/www/html/dvwa
              chmod -R 755 /var/www/html/dvwa
              systemctl restart apache2
              EOF

  tags = { Name = "ubuntu-victim" }
}

# ELK Stack (t2.medium)
resource "aws_instance" "elk" {
  ami                         = "ami-0c7217cdde317cfec"
  instance_type               = "t2.medium"
  key_name                    = "kali-key-east"
  vpc_security_group_ids      = [aws_security_group.elk_lab_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              apt update && apt install -y openjdk-11-jdk apt-transport-https curl wget
              curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
              echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | tee /etc/apt/sources.list.d/elastic-8.x.list
              apt update && apt install -y elasticsearch kibana logstash
              systemctl enable elasticsearch && systemctl start elasticsearch
              systemctl enable kibana && systemctl start kibana
              systemctl enable logstash && systemctl start logstash
              EOF

  tags = { Name = "elk-server" }
}

output "kali_public_ip" {
  value = aws_instance.kali.public_ip
}

output "victim_public_ip" {
  value = aws_instance.victim.public_ip
}

output "elk_public_ip" {
  value = aws_instance.elk.public_ip
}

resource "aws_security_group" "data_server" {
  name_prefix = "data_server-sg"

  tags = {
    "Name" = "data-server"
  }

#SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

#HTTP (For test)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

#Node_exporter
  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["172.31.0.0/16"]
  }

#Portainer
  ingress {
    from_port   = 9010
    to_port     = 9010
    protocol    = "tcp"
    cidr_blocks = ["213.109.238.102/32",
                   "46.175.248.249/32"]
  }

#Postman
  ingress {
    from_port   = 6901
    to_port     = 6901
    protocol    = "tcp"
    cidr_blocks = ["213.109.238.102/32",
                   "46.175.248.249/32",
                   "213.81.189.100/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "monitor" {
  name_prefix = "monitor-sg"

  tags = {
    "Name" = "monitor"
  }

#SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

#Node_exporter
  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["172.31.0.0/16"]
  }

#Prometheus
  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["213.109.238.102/32",
                   "172.31.0.0/16"]
  }

#Grafana
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["213.109.238.102/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "vpn" {
  name_prefix = "vpn-sg"

  tags = {
    "Name" = "vpc"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

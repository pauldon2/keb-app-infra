/*
#Server One
data "template_file" "init_data_vpn" {
  template = file("user_data/server_one.sh")
}
*/

resource "aws_instance" "server_vpn" {
  ami                         = var.ami_ubuntu_22_base
  instance_type               = "t3a.small"
  user_data                   = data.template_file.init_data.rendered
  security_groups             = [aws_security_group.data_server.name]
  key_name                    = "operator"
  source_dest_check           = false
  associate_public_ip_address = true
  root_block_device {
    volume_size           = 20
    delete_on_termination = true
    volume_type           = "gp3"
    throughput            = 125
  }

  /*
  lifecycle {
      ignore_changes = [root_block_device,ami,user_data]
  }
*/

  tags = {
    Name = "keb-server-vpn"
  }

  volume_tags = {
    Name = "keb-server-vpn"
  }

}

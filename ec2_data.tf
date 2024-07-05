#Server One
data "template_file" "init_data" {
  template = file("user_data/server_one.sh")
}

resource "aws_instance" "server_one" {
  ami                         = var.ami_ubuntu_22_base
  instance_type               = var.inst_type_server
  user_data                   = data.template_file.init_data.rendered
  security_groups             = [aws_security_group.data_server.name]
  key_name                    = "operator"
  source_dest_check           = false
  associate_public_ip_address = true
  root_block_device {
    volume_size           = 60
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
    Name = "keb-server-one"
  }

  volume_tags = {
    Name = "keb-server-one"
  }

}

#EIP for SERVER_ONE
resource "aws_eip" "server_one" {
  domain = "vpc"

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name     = "eip-server-one"
  }
}

resource "aws_eip_association" "server_one" {
  instance_id   = aws_instance.server_one.id
  allocation_id = aws_eip.server_one.id
}



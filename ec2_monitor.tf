#Monitoring server
data "template_file" "init_data_mon" {
  template = file("user_data/monitor.sh")
}

resource "aws_instance" "monitor" {
  ami                         = var.ami_ubuntu_22_base
  instance_type               = var.inst_type_server
  user_data                   = data.template_file.init_data_mon.rendered
  security_groups             = [aws_security_group.monitor.name]
  key_name                    = "operator"
  source_dest_check           = false
  associate_public_ip_address = true
  root_block_device {
    volume_size           = 100
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
    Name = "monitor"
  }

  volume_tags = {
    Name = "monitor"
  }

}

#EIP for Monitoring
resource "aws_eip" "monitor" {
  domain = "vpc"

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name     = "eip-monitor"
  }
}

resource "aws_eip_association" "monitor" {
  instance_id   = aws_instance.monitor.id
  allocation_id = aws_eip.monitor.id
}



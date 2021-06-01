resource "aws_instance" "test_cluster_m1" {
  ami           = data.aws_ami.base_image.id
  instance_type = "t2.small"
  key_name="terraform"
  vpc_security_group_ids = [aws_security_group.sec_group_block.id]
  tags = {
    Name = "test_cluster_m1"
  }
  provisioner "remote-exec" {
    inline = [
      "echo ${aws_eip.eip_m1.public_ip}",
      "echo ${aws_instance.test_cluster_m1.public_ip}"
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file("./terraform.pem")
    }
  }
}





resource "aws_instance" "test_cluster_m2" {
  ami           = data.aws_ami.base_image.id
  instance_type = "t2.small"
  key_name="terraform"
  vpc_security_group_ids = [aws_security_group.sec_group_block.id]
  tags = {
    Name = "test_cluster_m2"
  }
  provisioner "remote-exec" {
    inline = [
      "echo ${aws_eip.eip_m2.public_ip}",
      "echo ${aws_instance.test_cluster_m2.public_ip}"
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file("./terraform.pem")
    }
  }
}
resource "aws_instance" "test_cluster_w1" {
  ami           = data.aws_ami.base_image.id
  instance_type = "t2.small"
  key_name="terraform"
  vpc_security_group_ids = [aws_security_group.sec_group_block.id]
  tags = {
    Name = "test_cluster_w1"
  }
  provisioner "remote-exec" {
    inline = [
      "echo ${aws_eip.eip_w1.public_ip}",
      "echo ${aws_instance.test_cluster_w1.public_ip}"
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file("./terraform.pem")
    }
  }
}
resource "aws_instance" "test_cluster_w2" {
  ami           = data.aws_ami.base_image.id
  instance_type = "t2.small"
  key_name="terraform"
  vpc_security_group_ids = [aws_security_group.sec_group_block.id]
  tags = {
    Name = "test_cluster_w2"
  }
  provisioner "remote-exec" {
    inline = [
      "echo ${aws_eip.eip_w2.public_ip}",
      "echo ${aws_instance.test_cluster_w2.public_ip}"
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file("./terraform.pem")
    }
  }
}
resource "aws_instance" "test_cluster_w3" {
  ami           = data.aws_ami.base_image.id
  instance_type = "t2.small"
  key_name="terraform"
  vpc_security_group_ids = [aws_security_group.sec_group_block.id]
  tags = {
    Name = "test_cluster_w3"
  }
  provisioner "remote-exec" {
    inline = [
      "echo ${aws_eip.eip_w3.public_ip}",
      "echo ${aws_instance.test_cluster_w3.public_ip}"
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file("./terraform.pem")
    }
  }
}

##eip
resource "aws_eip" "eip_m1" {
  vpc = true
}
resource "aws_eip" "eip_m2" {
  vpc = true
}
resource "aws_eip" "eip_w1" {
  vpc = true
}
resource "aws_eip" "eip_w2" {
  vpc = true
}
resource "aws_eip" "eip_w3" {
  vpc = true
}
resource "aws_eip_association" "eip_assoc_m1" {
  instance_id   = aws_instance.test_cluster_m1.id
  allocation_id = aws_eip.eip_m1.id
}
resource "aws_eip_association" "eip_assoc_m2" {
  instance_id   = aws_instance.test_cluster_m2.id
  allocation_id = aws_eip.eip_m2.id
}
resource "aws_eip_association" "eip_assoc_w1" {
  instance_id   = aws_instance.test_cluster_w1.id
  allocation_id = aws_eip.eip_w1.id
}
resource "aws_eip_association" "eip_assoc_w2" {
  instance_id   = aws_instance.test_cluster_w2.id
  allocation_id = aws_eip.eip_w2.id
}
resource "aws_eip_association" "eip_assoc_w3" {
  instance_id   = aws_instance.test_cluster_w3.id
  allocation_id = aws_eip.eip_w3.id
}
###########

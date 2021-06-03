resource "aws_instance" "test_cluster_m1" {
  ami                    = data.aws_ami.base_image.id
  instance_type          = "t2.small"
  key_name               = "terraformec2"
  vpc_security_group_ids = [aws_security_group.sec_group_block.id]
  tags = {
    Name = "test_cluster_m1"
  }
}
 /*
resource "aws_instance" "test_cluster_m2" {
  ami                    = data.aws_ami.base_image.id
  instance_type          = "t2.small"
  key_name               = "terraformec2"
  vpc_security_group_ids = [aws_security_group.sec_group_block.id]
  tags = {
    Name = "test_cluster_m2"
  }
}
resource "aws_instance" "test_cluster_w3" {
  ami                    = data.aws_ami.base_image.id
  instance_type          = "t2.small"
  key_name               = "terraformec2"
  vpc_security_group_ids = [aws_security_group.sec_group_block.id]
  tags = {
    Name = "test_cluster_w3"
  }
}
*/
resource "aws_instance" "test_cluster_w1" {
  ami                    = data.aws_ami.base_image.id
  instance_type          = "t2.small"
  key_name               = "terraformec2"
  vpc_security_group_ids = [aws_security_group.sec_group_block.id]
  tags = {
    Name = "test_cluster_w1"
  }
}
resource "aws_instance" "test_cluster_w2" {
  ami                    = data.aws_ami.base_image.id
  instance_type          = "t2.small"
  key_name               = "terraformec2"
  vpc_security_group_ids = [aws_security_group.sec_group_block.id]
  tags = {
    Name = "test_cluster_w2"
  }
}

##eip
resource "aws_eip" "eip_m1" {
  vpc = true
}
resource "aws_eip" "eip_w1" {
  vpc = true
}
resource "aws_eip" "eip_w2" {
  vpc = true
}


/*
resource "aws_eip" "eip_m2" {
  vpc = true
}
resource "aws_eip" "eip_w3" {
  vpc = true
}
resource "aws_eip_association" "eip_assoc_m2" {
  instance_id   = aws_instance.test_cluster_m2.id
  allocation_id = aws_eip.eip_m2.id
}
resource "aws_eip_association" "eip_assoc_w3" {
  instance_id   = aws_instance.test_cluster_w3.id
  allocation_id = aws_eip.eip_w3.id
}
*/
resource "aws_eip_association" "eip_assoc_m1" {
  instance_id   = aws_instance.test_cluster_m1.id
  allocation_id = aws_eip.eip_m1.id
}
resource "aws_eip_association" "eip_assoc_w1" {
  instance_id   = aws_instance.test_cluster_w1.id
  allocation_id = aws_eip.eip_w1.id
}
resource "aws_eip_association" "eip_assoc_w2" {
  instance_id   = aws_instance.test_cluster_w2.id
  allocation_id = aws_eip.eip_w2.id
}
###########

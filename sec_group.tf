resource "aws_security_group" "sec_group_block" {
  name        = "custom_sec_group"

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" 
  }

  tags = {
    Name = "custom_sec_group"
  }
}

resource "aws_security_group" "sec_group_block" {
  name = "custom_sec_group"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "custom_sec_group"
  }
}

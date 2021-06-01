data "aws_ami" "base_image" {
  most_recent = true
  owners      = ["${var.datasource_ami_owner}"]

  filter {
    name   = "name"
    values = ["${var.datasource_ami_name_filter}"]
  }
}

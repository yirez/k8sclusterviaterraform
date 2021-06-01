
variable "iam_name" {
  default = "test_user"
  type    = string
}

variable "instance_name" {
  default = "this_is_prod"
  type    = string
}


variable "datasource_ami_owner" {
  default = "amazon"
  type    = string
}
variable "datasource_ami_name_filter" {
  default = "amzn2-ami-hvm*"
  type    = string
}

# data "aws_ami" "ami" {
#   most_recent      = true
#   owners           = ["amazon"]

#  filter {
#    name   = "name"
#    values = ["${var.ami_id}"]
#  }

# }
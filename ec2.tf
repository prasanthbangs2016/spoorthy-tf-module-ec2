# resource "aws_key_pair" "TF_key" {
#   key_name   = "TF_key"
#   public_key = tls_private_key.rsa.public_key_openssh
# }

# resource "tls_private_key" "rsa" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "local_file" "TF-key" {
#     content  = tls_private_key.rsa.private_key_pem
#     filename = "tfkey"
# }

#creating security group for ec2

resource "aws_security_group" "main" {
  name        = "spoorthy-${var.spoothy-bucket-tag-name}-ssh"
  description = "spoorthy-${var.spoothy-bucket-tag-name}-ssh"

  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }
  egress {
    description      = "egress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }


  tags = {
    Name = "spoorthy-${var.spoothy-bucket-tag-name}-ssh"
  }
}

resource "aws_instance" "spoorthy_vm" {
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.s3_profile.name}"
  security_groups = [aws_security_group.main.name]
  # key_name = "TF_key"


  tags = {
    Name = "${var.spoothy-bucket-tag-name}-vm"
  }
}


resource "null_resource" "ansible_apply" {
  provisioner "remote-exec" {
    connection {
      host = aws_instance.spoorthy_vm.private_ip
      user = "centos"
      password = "DevOps321"

    }
    inline = [
      "sudo yum update -y",
      "sudo yum install python3-pip -y",
      "sudo pip3 install pip --upgrade",
      "sudo pip3 install ansible-core",
      "ansible-pull -i localhost, -U https://github.com/prasanthbangs2016/spoorthy-ansible.git spoothy.yml"
    ]
  }
}


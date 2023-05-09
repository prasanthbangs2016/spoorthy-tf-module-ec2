resource "aws_key_pair" "TF_key" {
  key_name   = "TF_key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "TF-key" {
    content  = tls_private_key.rsa.private_key_pem
    filename = "tfkey"
}

#creating security group for ec2

resource "aws_security_group" "main" {
  name        = "spoorthy-${var.spoothy_bucket_tag_name}-ssh"
  description = "spoorthy-${var.spoothy_bucket_tag_name}-ssh"

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
    Name = "spoorthy-${var.spoothy_bucket_tag_name}-ssh"
  }
}

resource "aws_instance" "spoorthy_vm" {
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.s3-bucket.name}"
  security_groups = [aws_security_group.main.name]
  key_name = "TF_key"


  tags = {
    Name = "${var.spoothy_bucket_tag_name}-vm"
  }
}



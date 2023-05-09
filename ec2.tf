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


resource "aws_instance" "spoorthy_vm" {
  ami           = data.aws_ami.ami.image_id
  instance_type = "${var.instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.s3_bucket.name}"

  tags = {
    Name = "${var.spoothy_bucket_tag_name}-vm"
  }
}



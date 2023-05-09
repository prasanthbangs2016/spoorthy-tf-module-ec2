resource "aws_spot_instance_request" "spoorthy_vm" {
  ami           = data.aws_ami.ami.image_id
  instance_type = "${var.instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.s3_bucket.name}"
  wait_for_fulfillment = true

  tags = {
    Name = "${var.spoothy_bucket_tag_name}-vm"
  }
}


resource "aws_ec2_tag" "name" {
  resource_id = aws_spot_instance_request.spoorthy_vm.spot_instance_id
  key = "Name"
  value = "${var.spoothy_bucket_tag_name}"
}
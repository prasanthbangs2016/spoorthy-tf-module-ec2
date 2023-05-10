resource "aws_iam_policy" "s3-access" {
  name        = "spoorthy-${var.spoothy-bucket-tag-env}-s3-full-access"
  path        = "/"
  description = "spoorthy-${var.spoothy-bucket-tag-env}-s3-full-access"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "s3-bucket" {
  name = "spoorthy-${var.spoothy-bucket-tag-env}-s3-full-access"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      tag-key = "spoorthy-${var.spoothy-bucket-tag-env}-s3-full-access"
  }
}
resource "aws_iam_instance_profile" "s3_profile" {
  name = "spoorthy-${var.spoothy-bucket-tag-env}-s3-full-access"
  role = "${aws_iam_role.s3-bucket.name}"
}

resource "aws_iam_role_policy_attachment" "role-attach" {
  role       = aws_iam_role.s3-bucket.name
  policy_arn = aws_iam_policy.s3-access.arn
}
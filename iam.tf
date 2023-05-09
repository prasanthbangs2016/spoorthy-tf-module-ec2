# resource "aws_iam_role" "s3_bucket" {
#   name = "spoorthy-${var.spoothy_bucket_tag_env}_s3_full_access"

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": "ec2.amazonaws.com"
#       },
#       "Effect": "Allow",
#       "Sid": ""
#     }
#   ]
# }
# EOF

#   tags = {
#       tag-key = "spoorthy-${var.spoothy_bucket_tag_env}_s3_full_access"
#   }
# }

# resource "aws_iam_role_policy" "s3_policy" {
#   name = "spoorthy-${var.spoothy_bucket_tag_env}_s3_full_access"
#   role = "${aws_iam_role.s3_bucket.id}"

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": [
#         "s3:*"
#       ],
#       "Effect": "Allow",
#       "Resource": "*"
#     }
#   ]
# }
# EOF
# }
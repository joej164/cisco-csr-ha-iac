resource "aws_iam_instance_profile" "csr1000v" {
  name = "csr1000v"
  role = "${aws_iam_role.csr_role.name}"
}

resource "aws_iam_policy" "csrpolicy" {
  name        = "csr_policy"
  path        = "/"
  description = "My test policy"

  policy = <<EOF
{
"Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "cloudwatch:",
                "s3:",
                "ec2:AssociateRouteTable",
                "ec2:CreateRoute",
                "ec2:CreateRouteTable",
                "ec2:DeleteRoute",
                "ec2:DeleteRouteTable",
                "ec2:DescribeRouteTables",
                "ec2:DescribeVpcs",
                "ec2:ReplaceRoute",
                "ec2:DescribeRegions",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DisassociateRouteTable",
                "ec2:ReplaceRouteTableAssociation",
                "logs:CreateLogGroup",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "csr-attach" {
  role       = "${aws_iam_role.csr_role.name}"
  policy_arn = "${aws_iam_policy.csrpolicy.arn}"
}


resource "aws_iam_role" "csr_role" {
  name                 = "csr1000v"
  path                 = "/"
  permissions_boundary = aws_iam_policy.csrpolicy.arn

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
}


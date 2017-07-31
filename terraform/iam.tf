####################################################################
# Terraform -
#    Install the ec2-auto-shutdown & cloudwatch alarm to schedule the shutdown
#
# v1.0 - gosunilgo - sunil.soprey
#
#
####################################################################


resource "aws_iam_role" "autoshutdown-role" {
  name = "autoshutdown-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "autoshutdown-policy" {
    name        = "autoshudown-policy"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:StopInstances",
        "ses:SendEmail"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}


resource "aws_iam_role_policy_attachment" "attach1" {
    role       = "${aws_iam_role.autoshutdown-role.name}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_iam_role_policy_attachment" "attach2" {
    role       = "${aws_iam_role.autoshutdown-role.name}"
    policy_arn = "arn:aws:iam::aws:policy/AWSLambdaExecute"
}

resource "aws_iam_role_policy_attachment" "attach3" {
    role       = "${aws_iam_role.autoshutdown-role.name}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "attach4" {
    role       = "${aws_iam_role.autoshutdown-role.name}"
    policy_arn = "${aws_iam_policy.autoshutdown-policy.arn}"
}

resource "aws_iam_role" "main" {
  name = "${local.prefix}-cw-events-role"

  assume_role_policy = <<DOC
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
DOC
}

resource "aws_iam_role_policy" "main" {
  name = "${local.prefix}-cw-events-policy"
  role = "${aws_iam_role.main.id}"

  policy = <<DOC
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "lambda:*",
            "Resource": "arn:aws:lambda:${var.region}:${var.account_id}:function:*"
        }
    ]
}
DOC
}

# Create EC2

resource "aws_lambda_function" "backup_dyndb" {
  filename      = "${data.archive_file.lambda_archive.output_path}"
  function_name = local.lambda_name
  role          = "${aws_iam_role.lambda_role.arn}"
  handler       = "backup_dyndb.lambda_handler"

  source_code_hash = "${filebase64sha256("${path.root}/files/backup_dyndb.zip")}"

  depends_on = [
    "data.null_data_source.lambda_file",
    "data.archive_file.lambda_archive",
    "aws_cloudwatch_log_group.main"
  ]

  runtime = "python3.7"

  environment {
    variables = local.env_vars
  }
}

data "null_data_source" "lambda_file" {
  inputs = {
    filename = "${path.root}/files/backup_dyndb.py"
  }
}

data "null_data_source" "lambda_archive" {
  depends_on = ["data.null_data_source.lambda_file"]
  inputs = {
    filename = "${path.root}/files/backup_dyndb.zip"
  }
}

data "archive_file" "lambda_archive" {
  # count = var.create ? 1 : 0
  # depends_on  = ["data.null_data_source.lambda_archive"]
  type        = "zip"
  source_file = "${data.null_data_source.lambda_file.outputs.filename}"
  output_path = "${data.null_data_source.lambda_archive.outputs.filename}"
}



##LAMBDA

data "archive_file" "function" {
type        = "zip"
source_file  = "${path.module}/function/function.js"
output_path = "${path.module}/function.zip"
}

resource "aws_s3_bucket" "smvsbucket" {
    bucket = "smvsbucket120522"
    acl = "private"
}

resource "aws_s3_bucket_object" "object" {
    bucket = aws_s3_bucket.smvsbucket.id
    key = "function.zip"
    source = "${path.module}/function.zip"
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"

  assume_role_policy = file("function/lambda_role.json")
}

resource "aws_iam_role_policy" "lambda_policy" {
 
 name         = "lambda_policy"
 role         = aws_iam_role.lambda_role.id
 policy     =  file("function/lambda_policy.json")
}

resource "aws_lambda_function" "ScheduledLambda" {
  function_name = "ScheduledLambda"
  s3_bucket = aws_s3_bucket.smvsbucket.id
  s3_key = "function.zip"

  role    = aws_iam_role.lambda_role.arn
  handler = "function.handler"
  runtime = "nodejs12.x"
}

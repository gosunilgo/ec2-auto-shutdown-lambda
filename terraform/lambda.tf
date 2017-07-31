####################################################################
# Terraform -
#    Install the ec2-auto-shutdown & cloudwatch alarm to schedule the shutdown
#
# v1.0 - gosunilgo - sunil.soprey
#
#
####################################################################

resource "aws_lambda_function" "autoshutdown-lambda" {
 filename         = "${var.lambdazip}"
 function_name    = "autoshutdown-lambda"
 role             = "${aws_iam_role.autoshutdown-role.arn}"
 handler          = "shutdown.lambda_handler"
 source_code_hash = "${file(var.lambdazip)}"
 runtime          = "python2.7"


}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id   = "AllowExecutionFromCloudWatch"
  action         = "lambda:InvokeFunction"
  function_name  = "${aws_lambda_function.autoshutdown-lambda.function_name}"
  principal      = "events.amazonaws.com"
}

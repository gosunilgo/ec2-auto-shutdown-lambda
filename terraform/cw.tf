####################################################################
# Terraform -
#    Install the ec2-auto-shutdown & cloudwatch alarm to schedule the shutdown
#
# v1.0 - gosunilgo - sunil.soprey
#
#
####################################################################

resource "aws_cloudwatch_event_rule" "autoshutdown" {
  name        = "autoshutdown"
  description = "Automated shutdown of EC2 resources"

  ## time  in GMT!
  schedule_expression = "cron(0 2,4,5,9 * * ? *)"

}
resource "aws_cloudwatch_event_target" "autoshutdown" {
  target_id = "sendtolambda"
  rule      = "${aws_cloudwatch_event_rule.autoshutdown.name}"
  arn       = "${aws_lambda_function.autoshutdown-lambda.arn}"
}

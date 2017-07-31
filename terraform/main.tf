####################################################################
# Install the ec2-auto-shutdown & cloudwatch alarm to schedule the shutdown
# v1.0 - gosunilgo - sunil.soprey
#
#
####################################################################

terraform {
  backend "s3" {
  }
}

variable "lambdazip" {
  type = "string"
  default = "lambda.zip"
}

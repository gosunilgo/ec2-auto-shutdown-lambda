EC2 Auto Shutdown
=================
This lambda will check all the running EC2 instances and take the following actions:

- Do nothing if:
     - the instance is part of an autoscaling group
     - the instance is tagged with the tag defined in `EXCLUDE_TAG`
- Send an e-mail if the instance has been active between `MAIL_AFTER_HOURS` ago and `SHUTDOWN_AFTER_HOURS` ago
- Stop the instance if it has not been active between now and `SHUTDOWN_AFTER_HOURS` ago.

Dry Run
-------
By default `DRY_RUN` is set to `True`, to prevent accidental shutdown of instances. You should run this the first time in dry run mode, and look at the cloudwatch logs to determine wich instances will be stopped. Make sure to exclude instances with the `EXCLUDE_TAG` if necessary.

Installation
------------

0.  !!!   Please install terraform (found from terraform.io)  !!!
1.  Please run the go.sh 
    - creates a lambda.zip 
2. Runs terraform to provision assets
    - lambda (will upload the lamdba.zip from previous step)
    - cloudwatch rule
    - iam policies for autoshutdown 

to use SES, `MAIL_FROM` should be a verified address. If the account is still in the SES sandbox, `MAIL_TO` should also be verified.

Configuration
-------------
Please use the constants in the beginning of the lambda function for the configuration

- `DRY_RUN`: See above
- `MAIL_AFTER_HOURS`: The number of hours an instance should be inactive before sending an e-mail
- `SHUTDOWN_AFTER_HOURS`: The number of hours an instance should be inactive before sending an e-mail
- `EXCLUDE_TAG`:  If this tag is present on an instance, no action will be taken
- `MAIL_FROM`: `MAIL_TO` and `MAIL_TEXT` used to configure the sender, receiver and contents of the e-mail.
- `ASG_TAG`:  This should never change.

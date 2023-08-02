# Serverless S3 Event Notifier
This application is a serverless event-driven system leveraging AWS SNS to monitor two key events within an S3 bucket: file upload and file deletion.

## Working Concept
This repository contains the Terraform code to create an S3 bucket, SNS Topic and Subscriptions.

### File Upload event:
When a file is uploaded to the S3 bucket, an S3 event is triggered, invoking an SNS notification.

### File Delete event:
Similarly, when a file is deleted from the S3 bucket, an S3 event is triggered, invoking another SNS notification.

### SNS Topic & Notification:
These notifcations are sent to the SNS topic which has a subscription configured to send the notifications in `email-json` format.

`Notification on file upload to S3 bucket`

![s3-file-upload](https://github.com/Dylon-Chan/serverless-app-assignment-wengsiong/blob/main/photos/s3-upload-file-event-trigger-sns.png)

`Notification on file deleted from S3 bucket`

![s3-file-delete](https://github.com/Dylon-Chan/serverless-app-assignment-wengsiong/blob/main/photos/s3-delete-file-event-trigger-sns.png)

### Take note: Email Confirmation:
In order to receive the notifications, the email recipient must first confirm the subscription through a confirmation link sent via email. This can be done once the Terraform code is deployed.

`Email Subscription Confirmation`

![email-subscription-confirmation](https://github.com/Dylon-Chan/serverless-app-assignment-wengsiong/blob/main/photos/sns-email-subscription-confirmation.png)

## Benefits
This architecture provides a robust and scalable solution for tracking critical file changes within an S3 bucket, eliminating the need to manage server infrastructure. By utilizing SNS, users can receive email notifications automatically, allowing for easy expansion of the notification system to integrate with other AWS services or external systems.


## References
- [Terraform Registry: aws_sns_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic.html)
- [Terraform Registry: aws_sns_topic_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy.html)
- [Terraform Registry: aws_sns_topic_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription.html)
- [Terraform Registry: aws_s3_bucket_notification](https://registry.terraform.io/providers/hashicorp/aws/3.52.0/docs/resources/s3_bucket_notification)
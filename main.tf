resource "aws_sns_topic" "notify" {
  name = "wengsiong-event-sns"
}

data "aws_iam_policy_document" "sns_policy" {
  statement {
    effect = "Allow"

    principals {
      type = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions = [
      "SNS:Subscribe",
      "SNS:Publish"
    ]
    resources = [aws_sns_topic.notify.arn]

    condition {
      test = "ArnLike"
      variable = "aws:SourceArn"
      values = [aws_s3_bucket.bucket.arn]
    }
  }
}

resource "aws_sns_topic_policy" "attach_policy" {
  arn = aws_sns_topic.notify.arn
  policy = data.aws_iam_policy_document.sns_policy.json
}

resource "aws_s3_bucket" "bucket" {
  bucket = "wengsiong-trigger-sns-bucket"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bucket.id

  topic {
    topic_arn = aws_sns_topic.notify.arn
    events = ["s3:ObjectCreated:*","s3:ObjectRemoved:*"]
  }

  depends_on = [aws_sns_topic_policy.attach_policy]
}

resource "aws_sns_topic_subscription" "notify_owner" {
  topic_arn = aws_sns_topic.notify.arn
  protocol = "email-json"
  endpoint = var.email_address
  endpoint_auto_confirms = true
}
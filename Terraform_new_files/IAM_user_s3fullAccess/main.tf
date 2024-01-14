provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "wesley" {
  name = "Wesley"
}

resource "aws_iam_user_policy_attachment" "wesley_s3_full_access" {
  user       = aws_iam_user.wesley.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
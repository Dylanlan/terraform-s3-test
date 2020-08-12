resource "null_resource" "build" {
  provisioner "local-exec" {
    command = "cd ../app && yarn install && yarn build"
  }

  depends_on = [aws_s3_bucket.website_bucket]
}

resource "null_resource" "deploy" {
  provisioner "local-exec" {
    command = "aws s3 sync ../app/build/ s3://${var.bucket_name}"
  }

  depends_on = [null_resource.build]
}
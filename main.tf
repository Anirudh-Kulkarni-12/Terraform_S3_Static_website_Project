# Create S3 Bucket
resource "aws_s3_bucket" "mybucket" {
    bucket = var.bucket_name
}

resource "aws_s3_bucket_ownership_controls" "mybucket_owner" {
    bucket = aws_s3_bucket.mybucket.id

    rule {
      object_ownership = aws_s3_bucket.mybucket
    }
}

resource "aws_s3_bucket_public_access_block" "mybucket_public_access" {
    bucket = aws_s3_bucket.mybucket.id

    block_public_acls = false
    block_public_policy = false
    ignore_public_acls = false
    restrict_public_buckets = false
}
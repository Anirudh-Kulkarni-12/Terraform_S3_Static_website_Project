# Create S3 Bucket
resource "aws_s3_bucket" "mybucket" {
    bucket = var.bucket_name
}

resource "aws_s3_bucket_ownership_controls" "mybucket_owner" {
    bucket = aws_s3_bucket.mybucket.id

    rule {
      object_ownership = "BucketOwnerPreferred"
    }
}

resource "aws_s3_bucket_public_access_block" "mybucket_public_access" {
    bucket = aws_s3_bucket.mybucket.id

    block_public_acls = false
    block_public_policy = false
    ignore_public_acls = false
    restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "mybucket_acl" {
    depends_on = [ 
        aws_s3_bucket_ownership_controls.mybucket_owner,
        aws_s3_bucket_public_access_block.mybucket_public_access,
     ]  

     bucket = aws_s3_bucket.mybucket.id
     acl = "public-read"
}

resource "aws_s3_object" "indexfile" {
    bucket = aws_s3_bucket.mybucket.id
    key = "index.html"
    source = "index.html"
    acl = "public-read"
    content_type = "text/html"
}

resource "aws_s3_object" "errorfile" {
    bucket = aws_s3_bucket.mybucket.id
    key = "error.html"
    source = "error.html"
    acl = "public-read"
    content_type = "text/html"
}
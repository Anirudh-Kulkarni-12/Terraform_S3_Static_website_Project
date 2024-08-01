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

resource "aws_s3_object" "aboutfile" {
    bucket = aws_s3_bucket.mybucket.id
    key = "about.html"
    source = "about.html"
    acl = "public-read"
    content_type = "text/html"
}

resource "aws_s3_object" "contactfile" {
    bucket = aws_s3_bucket.mybucket.id
    key = "contact.html"
    source = "contact.html"
    acl = "public-read"
    content_type = "text/html"
}

resource "aws_s3_object" "stylesfile" {
    bucket = aws_s3_bucket.mybucket.id
    key = "styles.css"
    source = "styles.css"
    acl = "public-read"
    content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "my_s3_website" {
    bucket = aws_s3_bucket.mybucket.id
    index_document {
      suffix = "index.html"
    }

    error_document {
      key = "error.html"
    }
  depends_on = [ aws_s3_bucket_acl.mybucket_acl ]
}
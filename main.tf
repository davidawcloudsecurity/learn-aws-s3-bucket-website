# Define variables
variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "davidawcloudsecurity123"  # default value
}

variable "region" {
  description = "The AWS region to deploy the resources"
  type        = string
  default     = "us-east-1"  # default value
}

variable "env" {
  description = "The AWS region to deploy the resources"
  type        = string
  default     = "Production"  # default value
}

provider "aws" {
  region = var.region
}

# Create the S3 bucket
resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = var.bucket_name
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    Name        = "Static Website Bucket"
    Environment = var.env
  }
}

# Block public access settings using aws_s3_bucket_public_access_block
resource "aws_s3_bucket_public_access_block" "static_website" {
  bucket = aws_s3_bucket_website_configuration.static_website.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Upload website files from GitHub (assuming they are downloaded locally)
# You can manually sync these files, or use a local directory
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket_website_configuration.static_website.bucket
  key    = "index.html"
  source = "./public/index.html"  # Update with your local path
  acl    = "public-read"
}

resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket_website_configuration.static_website.bucket
  key    = "error.html"
  source = "./public/error.html"  # Update with your local path
  acl    = "public-read"
}
/* MVP no need
# Optional: Enable versioning on the bucket
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket_website_configuration.static_website.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

# Optional: Enable logging (Specify a logging bucket if needed)
resource "aws_s3_bucket_logging" "logging" {
  bucket = aws_s3_bucket_website_configuration.static_website.bucket

  logging {
    target_bucket = "your-logging-bucket-name"  # Replace with your logging bucket name
    target_prefix = "logs/"
  }
}

# Optional: Set up CloudFront distribution for the website (recommended for performance)
resource "aws_cloudfront_distribution" "static_website" {
  origin {
    domain_name = aws_s3_bucket_website_configuration.static_website.website_endpoint
    origin_id   = "S3-${aws_s3_bucket_website_configuration.static_website.bucket}"

    s3_origin_config {
      origin_access_identity = "origin-access-identity/cloudfront/your-identity-id"  # Optional for private access
    }
  }

  enabled = true
  is_ipv6_enabled = true
  comment = "CloudFront Distribution for Static Website"

  default_cache_behavior {
    target_origin_id = "S3-${aws_s3_bucket_website_configuration.static_website.bucket}"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods = ["GET", "HEAD"]
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  price_class = "PriceClass_100"  # Low-cost option (US, Canada, Europe)
  
  # SSL certificate for HTTPS (you can request one from ACM)
  viewer_certificate {
    acm_certificate_arn = "your-certificate-arn"  # Replace with your ACM certificate ARN
    ssl_support_method   = "sni-only"
  }

  # Optional: Logging for CloudFront
  logging_config {
    include_cookies = false
    bucket          = "your-cloudfront-logs-bucket"
    prefix          = "cloudfront-logs/"
  }
}
*/

output "website_url" {
  value = "http://${aws_s3_bucket_website_configuration.static_website.website_endpoint}"
}
/*
output "cloudfront_url" {
  value = "https://${aws_cloudfront_distribution.static_website.domain_name}"  # If using CloudFront
}
*/

# learning-s3-bucket-website
How to setup a static website with AWS S3 bucket

Place this in your bucket policy
```bash
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::<bucket-name>/*"
        }
    ]
}
```
Theme - https://github.com/sproogen/modern-resume-theme

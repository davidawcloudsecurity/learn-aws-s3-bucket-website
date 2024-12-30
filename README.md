# learning-s3-bucket-website
How to setup a static website with AWS S3 bucket
Theme - https://github.com/sproogen/modern-resume-theme

## https://developer.hashicorp.com/terraform/install
Install if running at cloudshell
```ruby
alias k=kubectl; alias tf="terraform"; alias tfa="terraform apply --auto-approve"; alias tfd="terraform destroy --auto-approve"; alias tfm="terraform init; terraform fmt; terraform validate; terraform plan"; sudo yum install -y yum-utils shadow-utils; sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo; sudo yum -y install terraform; terraform init
```
## How to Use Terraform Variables: Examples
Default is tfa else use below
```bash
bucketname="" ; \
region="";\
environment=""; \
echo "Bucketname: $bucketname"; \
echo "Region: $region"; \
echo "Environment: $environment"
```
```bash
tfa -var bucket_name=$bucketname -var region=$region -var env=$environment
```
### Draft
### References
- [ ] Security Engineer Learning Path https://www.cloudskillsboost.google/paths/15
- [ ] Security Engineering on AWS https://aws.amazon.com/training/classroom/security-engineering-on-aws/
- [ ] AWS Security https://www.appsecengineer.com/learning-paths/aws-security
- [ ] AWS Security Learning Path: https://app.letsdefend.io/path/aws-security-learning-path
- [ ] Security Engineering on AWS https://www.thedigitalacademy.tech.gov.sg/course/detail/security-engineering-on-aws-security-engineering-jam

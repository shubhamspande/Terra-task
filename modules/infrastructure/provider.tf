provider "aws" {
  region                  = "us-east-1"  # Change to your preferred region
  shared_credentials_files = ["~/.aws/credentials"]
  profile                 = "default"  # Uses the profile set up by `aws configure`
}

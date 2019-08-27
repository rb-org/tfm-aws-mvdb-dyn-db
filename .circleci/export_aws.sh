#!/bin/sh
mkdir -p ~/.aws

# AWS Account Credentials
echo -e "[default]" > ~/.aws/credentials
echo -e "aws_access_key_id = $access_key_ci_rb_cci" >> ~/.aws/credentials
echo -e "aws_secret_access_key = $secret_key_ci_rb_cci" >> ~/.aws/credentials


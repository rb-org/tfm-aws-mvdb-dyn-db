#!/bin/sh

apk --no-cache add openssl curl
tflint_latest_url=$(curl -s https://github.com/wata727/tflint/releases/latest |grep -o 'https://[^"]*' | sed 's/tag/download/' )
wget "$tflint_latest_url/tflint_linux_amd64.zip"
unzip tflint_linux_amd64.zip
mkdir -p /usr/local/tflint/bin
export PATH=/usr/local/tflint/bin:$PATH
install tflint /usr/local/tflint/bin
tflint --var-file=env/${WKSPC}.tfvars --error-with-issues
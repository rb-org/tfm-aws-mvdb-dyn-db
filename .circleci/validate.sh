#!/bin/sh

validate_failed="no"
TF_DIRS=$(find $(pwd) -type f -iname "*.tf*" -exec dirname '{}' \; | grep -v ".terraform" | sort | uniq | xargs echo)
for DIR in $TF_DIRS
do
    echo Processing $DIR
    lines=$(terraform validate -input=false -check-variables=false -no-color $DIR -var-file=env/${WKSPC}.tfvars | wc -l | sed 's/[^0-9]//g')
    if [ ${lines} != "0" ]
    then
    echo "Please run terraform validate ${file}"
    validate_failed="yes"
    fi
done
if [ ${validate_failed} != "no" ]; then exit 1; fi
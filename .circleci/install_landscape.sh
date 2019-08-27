#!/bin/sh

apk --no-cache add ruby ruby-bundler ruby-json diffutils
gem install terraform_landscape --no-document
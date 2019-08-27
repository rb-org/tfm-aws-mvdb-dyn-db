#!/bin/sh

apk --no-cache add python3
ln -s /usr/bin/python3.6 /usr/bin/python
pip3 install pip --upgrade
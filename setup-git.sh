#!/bin/bash

git config --global user.name "Hebi Li";
git config --global user.email "lihebi.com@gmail.com";
# default to ~/.my-credentials
git config --global credential.helper store;
git config --global push.default simple;

#!/bin/bash

git init 
git config --global --add safe.directory /var/www/html
git add .

git config --global user.email "fechtron@gmail.com"
git config --global user.name "Fechtron"

git commit -m "master"
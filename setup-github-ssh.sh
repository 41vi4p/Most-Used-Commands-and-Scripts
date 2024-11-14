#!/bin/bash

# Replace 'your_email@example.com' with you emailID linked with your github account. 

ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

eval "$(ssh-agent -s)"

ssh-add

# Displays the ssh key on terminal, copy the key and paste it on your Github
cat ~/.ssh/id_rsa.pub

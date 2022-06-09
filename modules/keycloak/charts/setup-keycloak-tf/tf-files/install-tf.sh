#!/bin/sh

ls -ls
echo "-----------------------"
terraform init
cat ./inputs.tfvars.json
terraform plan -var-file=./inputs.tfvars.json
terraform apply -auto-approve -var-file=./inputs.tfvars.json
echo "-----------------------"
ls -ls


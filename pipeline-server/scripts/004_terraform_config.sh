#!/bin/bash
# Script to automate the deployment of Terraform infrastructure

# Exit immediately if a command exits with a non-zero status
set -e

# Directory where your Terraform files are located
TF_DIR="/home/ec2-user/CMU-DevOps-Project/infrastructure"  # <<< update this if needed

# Change to the Terraform directory
cd "$TF_DIR"

echo "Initializing Terraform..."
terraform init

echo "Validating Terraform files..."
terraform validate

echo "Planning the Terraform deployment..."
terraform plan -out=tfplan

echo "Applying the Terraform plan..."
terraform apply -auto-approve "tfplan"

echo "Deployment complete!"
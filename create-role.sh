#!/bin/bash

# Bash script to create an IAM role with AmazonBraketFullAccess and AWSLambdaBasicExecutionRole policies attached

set -e

ROLE_NAME="BraketLambdaRole"
TRUST_POLICY_FILE="trust-policy.json"

# Create trust policy JSON file for Lambda
cat > $TRUST_POLICY_FILE <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

echo "Creating IAM role: $ROLE_NAME"
aws iam create-role \
  --role-name "$ROLE_NAME" \
  --assume-role-policy-document file://$TRUST_POLICY_FILE

echo "Attaching AmazonBraketFullAccess policy"
aws iam attach-role-policy \
  --role-name "$ROLE_NAME" \
  --policy-arn arn:aws:iam::aws:policy/AmazonBraketFullAccess

echo "Attaching AWSLambdaBasicExecutionRole policy"
aws iam attach-role-policy \
  --role-name "$ROLE_NAME" \
  --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole

echo "Role $ROLE_NAME created and policies attached."

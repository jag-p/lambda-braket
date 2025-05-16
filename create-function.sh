#!/bin/bash

image_name="braket-lambda"
region="us-east-1"

account=$(aws sts get-caller-identity --query Account --output text)
fullname="${account}.dkr.ecr.${region}.amazonaws.com/${image_name}:latest"

aws lambda create-function \
  --function-name braket-lambda \
  --package-type Image \
  --code ImageUri=${fullname} \
  --role arn:aws:iam::${account}:role/BraketLambdaRole \
  --timeout 900 
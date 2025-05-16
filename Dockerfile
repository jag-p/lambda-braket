FROM public.ecr.aws/lambda/python:3.12

# Install Braket SDK and dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt --target "${LAMBDA_TASK_ROOT}"

# Copy function code
COPY lambda_function.py ${LAMBDA_TASK_ROOT}

# Set Lambda handler (matches function filename and handler name)
CMD ["lambda_function.handler"]


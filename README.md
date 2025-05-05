# Know-Your-Customer (KYC) Project
Thank you for checking out this project! This is a practice AWS microservice solution developed as part of the AWS Cloud Institute - Developer Intermediate course. The repository contains code and deployment instructions.

## Objectives:
The solution validates customer documents submitted via a mobile application. Input documents include:
- A **CSV** file with customer application details.
- A **customer selfie photo**.
- A **copy of the driver's license**.
The solution performs the following validations:
- **Data Consistency**: The application details must match the driver's license information.
- **Photo Matching**: The selfie and driver’s license photos must match (using facial recognition).
- **Third-Party Verification**: The submitted data must align with an independent driver’s license validation service.


## Required AWS services and functions:
- **S3 bucket**: store the application information customers submited
- **AWS Lambda function**: unzip customer's information package and process the information. The function compares the extracted data (name, address, date of birth) with the customer information. It also sends requests to Amazon Rekognition, Amazon Textract, and Amazon Simple Queue Service (Amazon SQS) for additional validations.
- **Amazon DynamoDB table**: store the information a customer submits to the application. 
- **Amazon SNS topic**: send notifications about the status of customers' applications.
- **Amazon Rekognition**: Lambda function will call Amazon Rekognition to compare the selfie and driver's license photos submitted by the customer. Next, it will update the DynamoDB table and publish Amazon SNS notifications based on the results of the comparison.
- **Amazon Textract**: Lambda function will call Amazon Textract to verify that the license image information matches the customer details.
- **IAM role**: create an AWS Identity and Access Management (IAM) role for each of the Lambda functions in this solution, following the principle of least privilege.

## Deployment Steps
1. Create an S3 Bucket
- Purpose: Store customer documents.
- Requirements:
  - Enable server-side encryption (SSE-S3 recommended).
  - Block all public access.

2. Create an IAM Role
- Purpose: Grant Lambda permissions to process documents.
- Steps:
  1. Create a new IAM role.
  2. Attach the IAM_Role_Permissions JSON policy.

3. Create a DynamoDB Table
- Purpose: Store processed customer data.

4. Deploy via AWS Cloud9
- Copy all folders (including app.py and template.yaml) to your Cloud9 environment.
- Run in the terminal: sam build && sam deploy

## Testing
Upload a ZIP file to the S3 bucket containing:
Driver’s license image.
Selfie image.
Application details (CSV).
The Lambda functions will:
Unzip the files.
Validate faces/texts.
Store results in DynamoDB.

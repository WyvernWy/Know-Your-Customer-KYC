# Know-Your-Customer-KYC Project 
  - a Practice AWS microservice soultion


## Objectives:
The solution validates customer documents submitted by a mobile application. The input documents include a comma-separated values (.csv) file containing customer application information, a customer selfie photo, and a copy of the customer's driver's license. Then the solution will perform the following validations: 
  - The customer's information submitted in the application must match the information on the driver's license.
  - The customer's selfie and driver's license photos must match.
  - The customer's information must match the data stored by an independent third-party driver's license validation service.


## Required AWS services and functions:
- **S3 bucket**: store the application information customers submited
- **AWS Lambda function**: unzip customer's information package and process the information. The function compares the extracted data (name, address, date of birth) with the customer information. It also sends requests to Amazon Rekognition, Amazon Textract, and Amazon Simple Queue Service (Amazon SQS) for additional validations.
- **Amazon DynamoDB table**: store the information a customer submits to the application. 
- **Amazon SNS topic**: send notifications about the status of customers' applications.
- **Amazon Rekognition**: Lambda function will call Amazon Rekognition to compare the selfie and driver's license photos submitted by the customer. Next, it will update the DynamoDB table and publish Amazon SNS notifications based on the results of the comparison.
- **Amazon Textract**: Lambda function will call Amazon Textract to verify that the license image information matches the customer details.
- **IAM role**: create an AWS Identity and Access Management (IAM) role for each of the Lambda functions in this solution, following the principle of least privilege.


## Step1. Create an S3 bucket
Create an S3 bucket to store the customers’ application documents.
- Make sure the Bucket is encrypted. Suggested "Server-side encryption with Amazon S3 managed keys (SSE-S3)" for encryption.
- The bucket should not be public. "Block all public access" option should be selected.

## Step2. Create an IAM role
AWS Lambda function needs an IAM execution role with the required permissions to process the customer’s documents.
Create a new IAM role and configure the permissions policy using the JSON file "IAM_Role_Permissions". Then, attach the permissions policy to the IAM role.

## Step3. Create a DynamoDB table
Create a DynamoDB table to store the customers’ information that was uploaded by the application and processed by AWS Lambda functions.

## Step4. Finish deploy in AWS Cloud9
Now copy all folders contaning the app.py scripts along with the template.yaml into the AWS Cloud9 environment.
In the AWS Cloud9 bash terminal, run command "sam build && sam deploy".

Now we have all the AWS Lambda functions, S3 bucekt, and DynamoDB table ready.
Please upload a zip file, to the S3 bucket, that contains an image copy of applicants' driver's license, a selfie image, and application detail.
The Lambda functions will automatically unzip the files and compare face and texts between those files and reture result into the DynamoDB table.

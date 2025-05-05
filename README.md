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


## Required AWS Services and Functions:
- **S3 Bucket**: Stores the application information customers submit.
- **AWS Lambda Function**: Unzips the customer's information package and processes the data. The function compares extracted details (name, address, date of birth) with the submitted information and triggers additional validations via:
  - **Amazon Rekognition**: Compares the selfie and driver’s license photos.
  - **Amazon Textract**: Validates license image text against customer details.
  - **Amazon SQS**: Queues validation tasks.
- **Amazon DynamoDB Table**: Stores customer-submitted application data.
- **IAM Role**: Secures each Lambda function with least-privilege permissions.

## Deployment Steps
### 1. Create an S3 Bucket
- **Purpose**: Store customer documents.
- **Requirements**:
  - Enable server-side encryption (SSE-S3 recommended).
  - Block all public access.

### 2. Create an IAM Role
- **Purpose**: Grant Lambda permissions to process documents.
- **Steps**:
  1. Create a new IAM role.
  2. Attach the IAM_Role_Permissions JSON policy.

### 3. Create a DynamoDB Table
- **Purpose**: Store processed customer data.

### 4. Deploy via AWS Cloud9
- Copy all folders (including app.py and template.yaml) to your Cloud9 environment.
- Run in the terminal:
  - sam build && sam deploy

## Testing
Upload a ZIP file to the S3 bucket containing:
- Driver’s license image.
- Selfie image.
- Application details (CSV).

The Lambda functions will:
- Unzip the files and store unzipped files back into S3.
- Validate faces/texts.
- Store results in DynamoDB.

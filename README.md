# Know-Your-Customer-KYC

# Lab 06
## Objectives:
Using AWS Lamda with AWS SDK for Python (Boto3) to create a function that compare the customer's ID with corresponding information submitted by the customer. Based on the result of comparison, the Lambda function must add a new key-value pair in the DynamoDB table with the result and also send an Amazon SNS notification.

## How to use:
### Configure the Lambda function IAM role permissions
- Open IAM.
- In the left navigation pane, in the Access management section, choose Policies.
- On the Policies page, choose Create policy.
- On the Specify permissions page, choose JSON.
- In the Policy editor pane, replace any existing policy with the JSON script.
- Choose Next.
- In the Review and create pane, for the Policy name, enter Lab6DocumentPolicy.
- Choose Create policy.
- On the Policies page, find and select the Lab6DocumentPolicy option.
- From the Actions menu, choose Attach.
- On the Attach as a permissions policy page, find and select the DocumentLambdaRole.
- Choose Attach policy.

### Update the Lambda function code
- Put the app.py file in AWS Cloud9



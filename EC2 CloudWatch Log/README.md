## Importing EC2 Logs to Amazon CloudWatch
This guide outlines the process for sending EC2 instance logs to CloudWatch Logs.

## IAM Role Requirements
The following IAM permissions are required for the EC2 instance role:
```json

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams",
                "logs:PutLogEvents",
                "logs:GetLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
```

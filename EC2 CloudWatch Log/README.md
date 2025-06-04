## Subject
This Section guides the steps of importing EC2 logs into CloudWatch.

## IAM Role and Permission Required
```json
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Effect": "Allow",
			"Action": [
				"logs:GetLogEvents",
				"logs:PutLogEvents",
				"logs:DescribeLogGroups",
				"logs:CreateLogGroup",
				"logs:DescribeLogStreams",
				"logs:CreateLogStream",
			],
			"Resource": "*"
		}
	]
}
```

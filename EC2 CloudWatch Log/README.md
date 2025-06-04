## Subject
This Section guides the steps of importing EC2 logs into CloudWatch.

## IAM Role and permission required.
```json
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Effect": "Allow",
			"Action": [
				"logs:GetLogEvents",
				"logs:DescribeLogStreams",
				"logs:DescribeLogGroups",
				"logs:PutLogEvents",
				"logs:CreateLogGroup",
				"logs:CreateLogStream",
				"logs:DescribeLogStreams"
			],
			"Resource": "*"
		}
	]
}
```

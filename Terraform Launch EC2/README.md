# Launch EC2 Instances Using Terraform 
This guide walks through the launch of an EC2 instance in AWS using Terraform scripts from the AWS CloudShell environment.

## Prerequisites
- An active AWS account with permissions to create EC2 instances.
- AWS CloudShell access.
- Basic familiarity with AWS and Terraform.

## Steps
**1. Create a Terraform Directory**
Open your AWS CloudShell terminal and run the following commands to create and move into a working directory:
```bash
mkdir terraform-ec2
cd terraform-ec2
```

**2. Create Terraform Configuration File**
Create a new Terraform file named `main.tf`:
```bash
nano main.tf
```
Then paste the following Terraform configuration:
```hcl
# main.tf
provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "EC2tmp" {
  ami           = "ami-0c2da9ee6644f16e5"
  instance_type = "t2.micro"
  
  tags = {
    Name = "CloudShell-Terraform-EC2"
  }
}

output "instance_public_ip" {
  value = aws_instance.EC2tmp.public_ip
}
```
Save (`Ctrl+O`, then `Enter`) and exit (`Ctrl+X`).

**3. Initialize Terraform**
Run the following command to initialize Terraform, which will download the required provider plugins:
```bash
terraform init
```

**4. Preview the Terraform Execution Plan**
To see what resources will be created, run:
```bash
terraform plan
```
(Optional) Validate your Terraform files:
```bash
terraform validate
```

**5. Apply the Terraform Plan to Launch EC2**
Execute the Terraform script to create the EC2 instance:
```bash
terraform apply
```
When prompted, type `yes` to confirm.
After the apply completes, the public IP of the instance will be displayed.

**6. Clean Up (Optional)**
Once done, to terminate the EC2 instance and clean up the resources, run:
```bash
terraform destroy
```
Confirm with `yes` when prompted.

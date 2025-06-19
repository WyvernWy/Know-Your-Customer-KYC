# Launch EC2 Instances Using Terraform 
This section is to launch EC2 using scripts through Terraform. This project is running in AWS CloudShell environment.

## Steps
1. Create a Terraform Directory
Run these commands in CloudShell:
```bash
mkdir terraform-ec2
cd terraform-ec2
```
2. Create Terraform Files
Use `nano` (or `vim`) to create `main.tf`:
```bash
nano main.tf
```
Paste the following Terraform code:
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

3. Initialize Terraform
```bash
terraform init
```
This sets up the AWS provider.

4. Preview Changes
```bash
terraform plan
```
This shows what resources will be created.
You can also run `terraform validate` to check your configuration.

5. Apply the Terraform Script
```bash
terraform apply
```
Type `yes` when prompted to confirm.

6. Clean Up (Optional)
To delete the EC2 instance later:
```bash
terraform destroy
```
Type `yes` to confirm.

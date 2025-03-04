# terraform aws lab-01

## Architecture
![target architecture](images/tf-aws-lab-01-architecture.jpeg)

## Requirements

### Having Terraform installed / Install Terraform
- Install Terraform from https://developer.hashicorp.com/terraform/install

- Test Installation
```shell
terraform --version
```

![img-01](images/img-01.png)

### Having AWS CLI installed / Install AWS CLI
- Configure AWS CLI
```shell
aws configure
```
1. Set Your Access Key ID
2. Set Secret Access Key
3. Set the default region : eu-west-3 (We will use Paris for this lab)
4. Output format : json

![img-02](images/img-02.png)

- Test Config
```shell
aws ec2 describe-vpcs --region eu-west-3
```

![img-03](images/img-03.png)

## Deployment
Create a main.tf file with the same contents as the one in the repository
![img-04](images/img-04.png)

Generate a ssh key for having access to your ec2 instance
```shell
ssh-keygen -t rsa -b 2048 -f ~/.ssh/tf-aws-lab-01 -C "tf-aws-lab-01" -N ""
```
![img-05](images/img-05.png)

Checking before deployment(there is no ec2 instance or security group):
![img-06](images/img-06.png)
![img-06-b](images/img-06-b.png)

Initialize the project
```shell
terraform init
```
![img-07](images/img-07.png)

Plan deployment
```shell
terraform plan
```
![img-08](images/img-08.png)
![img-08-b](images/img-08-b.png)

Apply deployment
```shell
terraform apply
```
![img-09](images/img-09.png)
confirm by tapping yes
![img-09-b](images/img-09-b.png)
![img-10](images/img-10.png)

Checking after deployment(there is no ec2 instance or security group):

![img-11](images/img-11.png)
![img-11-b](images/img-11-b.png)

## Testing
Connect to our created ec2 instance
```shell
ssh -i ~/.ssh/tf-aws-lab-01.pem ec2-user@<PUBLIC_IP>
```
![img-12](images/img-12.png)

## Destruction
Destroy our infrastructure
```shell
terraform destroy
```
![img-13](images/img-13.png)

confirm by tapping yes
![img-13-b](images/img-13-b.png)

![img-14](images/img-14.png)

Checking after destruction(there is no ec2 instance or security group):

![img-15](images/img-15.png)
![img-16](images/img-16.png)

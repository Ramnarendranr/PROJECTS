# Automated Email Notifications using SNS and EC2

This project sets up an automated system to send email notifications every 5 minutes using AWS Simple Notification Service (SNS) and an EC2 instance.

## Table of Contents

- Introduction
- Architecture
- Prerequisites
- Setup Instructions
    * Step 1: Create an SNS Topic and Subscribe an Email
    * Step 2: Set Up an EC2 Instance
    * Step 3: Install AWS CLI on the EC2 Instance
    * Step 4: Create a Script to Publish to SNS Topic
    * Step 5: Schedule the Script Using Cron
- Troubleshooting

### Introduction
```
This project demonstrates how to use AWS services to send periodic email notifications. An EC2 instance runs a cron job every 5 minutes, which triggers an SNS topic to send an email to a specified address.
```

### Architecture
```
AWS SNS: Used to manage and send notifications to subscribed endpoints.
AWS EC2: Hosts a script that triggers the SNS topic every 5 minutes.
Cron: Schedules and executes the script at regular intervals.
```

### Prerequisites
```
AWS Account
Basic knowledge of AWS services and Linux commands
SSH key pair for accessing the EC2 instance
```

### Setup Instructions

**Step 1: Create an SNS Topic and Subscribe an Email**
```
Log in to the AWS Management Console:
Navigate to SNS:
In the AWS Management Console, search for "SNS" and select "Simple Notification Service."
Create an SNS Topic:
Click on "Create topic."
Choose "Standard" as the type.
Enter a name for your topic, e.g., EmailNotifications.
Click "Create topic."
Subscribe Your Email to the Topic:

In the SNS dashboard, select your newly created topic.
Click on "Create subscription."
For Protocol, choose "Email."
For Endpoint, enter your email address.
Click "Create subscription."
Check your email and confirm the subscription by clicking the link in the confirmation email from AWS.
```

**Step 2: Set Up an EC2 Instance**
```
Launch an EC2 Instance:
In the AWS Management Console, search for "EC2" and select "EC2."
Click on "Launch instance."
Choose an Amazon Linux 2 AMI (or any other preferred AMI).
Choose an instance type (e.g., t2.micro, which is free-tier eligible).
Configure the instance details, add storage, and add tags as needed.
Configure the security group to allow SSH access (port 22) from your IP.
Launch the instance and connect to it via SSH.
```

**Step 3: Install AWS CLI on the EC2 Instance**

Connect to Your EC2 Instance via SSH:
```
ssh -i /path/to/your-key.pem ec2-user@<your-ec2-instance-public-ip>
```

Update the package list and install crontab:
```
sudo yum update -y
sudo yum install cronie -y
```

Configure AWS CLI with your credentials:
```
aws configure
Enter your AWS Access Key ID, Secret Access Key, region (e.g., us-east-1), and output format (e.g., json).
```

**Step 4: Create a Script to Publish to SNS Topic**
Create a Script to Send SNS Messages:
```
nano send-sns-email.sh
```

Add the Following Script:
```
#!/bin/bash

TOPIC_ARN="arn:aws:sns:us-east-1:123456789012:EmailNotifications"  # Replace with your SNS topic ARN
MESSAGE="This is a scheduled email from EC2 instance."
SUBJECT="Scheduled Email"

aws sns publish --topic-arn "$TOPIC_ARN" --message "$MESSAGE" --subject "$SUBJECT"
```

Make the Script Executable:
```
chmod +x send-sns-email.sh
```

**Step 5: Schedule the Script Using Cron**

Edit the Crontab:
```
crontab -e
```

Add the Cron Job to Run Every 5 Minutes:
```
*/5 * * * * /home/ec2-user/send-sns-email.sh
```

Start the cron job:
```
sudo systemctl status crond
sudo systemctl start crond
sudo systemctl enable crond
```

After a few minutes, check for the emails


### Troubleshooting
```
If you are not receiving emails:

Verify SNS Subscription Status:

Ensure the email subscription status is "Confirmed" in the SNS console.
Test SNS Topic Manually:

Publish a test message to the SNS topic from the console.
Check AWS CLI Configuration:

Ensure the AWS CLI is configured with correct credentials.
Run the Script Manually:

Execute ./send-sns-email.sh manually and check for errors.
Check Cron Logs:

Verify that the cron job is running and check the output log (/home/ec2-user/cron.log).
Ensure Cron Service is Running:

sh
Copy code
sudo systemctl status crond
Start the service if it’s not running:

sh
Copy code
sudo systemctl start crond
sudo systemctl enable crond
```

## SNS topic:



## EC2 instance:

## send email script file:

## crontab:

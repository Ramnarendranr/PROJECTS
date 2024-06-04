# Hosting WordPress on AWS Lightsail with Custom Domain Name

## Introduction
```
Amazon Lightsail is a user-friendly cloud computing platform provided by Amazon Web Services (AWS) that simplifies the deployment and management of virtual private servers (instances), storage, databases, and networking resources in the cloud. With its easy-to-use interface, predictable pricing, and integrated services, Lightsail enables developers and businesses to quickly launch and scale applications without the complexities typically associated with cloud infrastructure management.
This document provides a comprehensive guide to hosting a WordPress website on Amazon Lightsail using a custom domain name. Amazon Lightsail offers a simplified way to deploy and manage virtual private servers (instances) in the cloud, making it an ideal choice for hosting websites.
```

## Project Overview

### Creation of Lightsail Instances
```
Two instances are created on Amazon Lightsail to host WordPress.
The instances are configured with the necessary resources based on the expected traffic and requirements of the WordPress website.
```

### Configuration of Load Balancer
```
A load balancer is provisioned to distribute incoming traffic across the instances.
Both Lightsail instances are attached to the load balancer to ensure high availability and scalability.
```

### SSL Certificate Setup
```
A Secure Sockets Layer (SSL) certificate is created within the load balancer for enhanced security.
The SSL certificate is validated and successfully attached to the load balancer, enabling encrypted communication between the users and the website.
```

### Domain and DNS Configuration
```
A DNS zone is configured to manage the domain settings for the custom domain name.
A records and CNAME records are added to point the custom domain to the load balancer's endpoint, allowing users to access the website using the custom domain.
```

## Detailed Steps

### 1. Creation of Lightsail Instances
```
Step 1: Log in to the AWS Management Console.
Step 2: Navigate to the Lightsail service.
Step 3: Click on "Create instance" and select the appropriate instance plan.
Step 4: Choose the desired region and configure the instance settings (e.g., instance image, SSH key pair).
Step 5: Launch the instance and repeat the process to create a second instance for redundancy.
```

### 2. Configuration of Load Balancer
```
Step 1: In the Lightsail dashboard, go to the Networking tab.
Step 2: Click on "Create load balancer" and choose the desired load balancer plan.
Step 3: Configure the load balancer settings, including listeners, health checks, and SSL/TLS certificate.
Step 4: Attach both Lightsail instances to the load balancer to evenly distribute incoming traffic.
Step 5: Review and create the load balancer.
```

### 3. SSL Certificate Setup
```
Step 1: Within the load balancer settings, navigate to the "Certificates" tab.
Step 2: Click on "Create certificate" and enter the custom domain name.
Step 3: Follow the validation process to validate the SSL certificate.
Step 4: Once validated, attach the SSL certificate to the load balancer to enable HTTPS communication.
```

### 4. Domain and DNS Configuration
```
Step 1: Navigate to the domain registrar's website where the domain is registered.
Step 2: Access the DNS management section for the custom domain (www.example.com).
Step 3: Add an A record pointing to the load balancer's endpoint IP address.
Step 4: Add a CNAME record for the www subdomain pointing to the load balancer's endpoint hostname.
Step 5: Save the DNS settings and allow time for propagation.
```

### By following the steps outlined in this document, you have successfully deployed a WordPress website on Amazon Lightsail with a custom domain name. The use of load balancers and SSL certificates ensures high availability, scalability, and security for your website, providing an optimal user experience for visitors.

## References
```
Amazon Lightsail Documentation: https://lightsail.aws.amazon.com/ls/docs/en_us
AWS Certificate Manager Documentation: https://docs.aws.amazon.com/acm/index.html
WordPress Documentation: https://wordpress.org/support/
```


## Wordpress Instances:
<img width="1470" alt="Screenshot 2024-06-03 at 8 08 47 PM" src="https://github.com/Ramnarendranr/PROJECTS/assets/122247354/6bfd2ba6-11e2-47d8-a464-f4a49189f52b">


## Load balancer - Attached to instances:
<img width="1470" alt="Screenshot 2024-06-03 at 8 17 20 PM" src="https://github.com/Ramnarendranr/PROJECTS/assets/122247354/6cc10dc5-5326-4114-b91d-ef85d1653e49">


## Load balancer - Certificate:
<img width="1470" alt="Screenshot 2024-06-03 at 8 08 23 PM" src="https://github.com/Ramnarendranr/PROJECTS/assets/122247354/1f49c610-03b1-4df7-94d2-c1bebbc10e44">


## DNS record:
<img width="1470" alt="Screenshot 2024-06-03 at 8 08 43 PM" src="https://github.com/Ramnarendranr/PROJECTS/assets/122247354/0f758859-96be-4834-b58c-05a9d07f2744">


## secured website pointing to the wordpress site:
<img width="1470" alt="Screenshot 2024-06-03 at 8 07 45 PM" src="https://github.com/Ramnarendranr/PROJECTS/assets/122247354/5892ace4-af9c-475b-a2aa-0b4bb34c69d4">


# S3 Static Website Hosting with custom domain name

## Objective:
```
The purpose of this document is to outline the steps taken to host the ExploreWithRam.com website on Amazon S3 (Simple Storage Service) using static website hosting.
```

### 1. Domain Name Creation:
```
Purchase the custom domain name from a domain registrar.
my domain name: www.explorewithram.com
```

### 2. S3 Bucket Creation:
```
Created an S3 bucket in amazon AWS to host the static website content.
```

### 3. File Addition (Optional):
```
Uploaded website files (HTML, CSS, JavaScript, images, etc.) to the S3 bucket.
```

### 4. Permissions Configuration:

Implemented a bucket policy to allow public access to the website content.
```
Bucket Policy:
{
    "Version": "2012-10-17",
    "Id": "Policy1717194235114",
    "Statement": [
        {
            "Sid": "Stmt1717194233605",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::explorewithram.com/*"
        }
    ]
}
```

### 5. Properties Configuration:
```
Enabled static website hosting for the S3 bucket.
Selected "Redirect requests for an object" as the hosting type.
Entered the domain name "www.explorewithram.com" as the redirect target.
```

### 6. Verification:
```
Clicking on the S3 static website hosting endpoint will now redirect users to the ExploreWithRam.com website.
```

# The ExploreWithRam.com website is now successfully hosted on Amazon S3 using static website hosting. With proper permissions and configurations in place, the website is accessible to users via the designated domain name.


# S3 Bucket:

# Bucket policy:

# Static website hosting changes:

# Static website hosting endpoint:

# my custom domain:


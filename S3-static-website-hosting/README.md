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

## The ExploreWithRam.com website is now successfully hosted on Amazon S3 using static website hosting. With proper permissions and configurations in place, the website is accessible to users via the designated domain name.


## S3 Bucket:
<img width="1144" alt="s3-static-website-3" src="https://github.com/Ramnarendranr/PROJECTS/assets/122247354/25f54e4f-d567-40ed-98fa-e24b49d7251a">


## Bucket policy:
<img width="1131" alt="s3-static-website-4" src="https://github.com/Ramnarendranr/PROJECTS/assets/122247354/9353ac18-3f9e-4b65-bb97-058f4b65c10a">

## Static website hosting changes:
<img width="943" alt="s3-static-website" src="https://github.com/Ramnarendranr/PROJECTS/assets/122247354/92c5d826-3c4d-477c-a18b-f75b7ccce892">

## Static website hosting endpoint:
<img width="1125" alt="s3-static-website-5" src="https://github.com/Ramnarendranr/PROJECTS/assets/122247354/47eae85a-aa0d-4527-90f1-a4bef1c495f8">


# my custom domain:
![s3-static-website-6](https://github.com/Ramnarendranr/PROJECTS/assets/122247354/7107920e-f262-47dd-92cd-197fa7cdd1df)

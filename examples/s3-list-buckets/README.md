# s3-list-buckets

Example Zig project to all list buckets in an AWS account.

# Usage

Your AWS credentials must be in scope. The AWS SDK for Zig aims to follow the standardized [credential provider chain](https://docs.aws.amazon.com/sdkref/latest/guide/standardized-credentials.html) used by official AWS SDKs, so you can define your credentials using environment variables, credential files, IMDS, etc.

Example using the AWS_PROFILE environment variable:

```
export AWS_PROFILE=acme
```

Run the example:

```
zig build run
```

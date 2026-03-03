/// The code for the Lambda function. You can either specify an object in Amazon
/// S3, upload a .zip file archive deployment package directly, or specify the
/// URI of a container image.
pub const FunctionCode = struct {
    /// URI of a [container
    /// image](https://docs.aws.amazon.com/lambda/latest/dg/lambda-images.html) in
    /// the Amazon ECR registry.
    image_uri: ?[]const u8 = null,

    /// An Amazon S3 bucket in the same Amazon Web Services Region as your function.
    /// The bucket can be in a different Amazon Web Services account.
    s3_bucket: ?[]const u8 = null,

    /// The Amazon S3 key of the deployment package.
    s3_key: ?[]const u8 = null,

    /// For versioned objects, the version of the deployment package object to use.
    s3_object_version: ?[]const u8 = null,

    /// The ARN of the Key Management Service (KMS) customer managed key that's used
    /// to encrypt your function's .zip deployment package. If you don't provide a
    /// customer managed key, Lambda uses an [Amazon Web Services owned
    /// key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-owned-cmk).
    source_kms_key_arn: ?[]const u8 = null,

    /// The base64-encoded contents of the deployment package. Amazon Web Services
    /// SDK and CLI clients handle the encoding for you.
    zip_file: ?[]const u8 = null,

    pub const json_field_names = .{
        .image_uri = "ImageUri",
        .s3_bucket = "S3Bucket",
        .s3_key = "S3Key",
        .s3_object_version = "S3ObjectVersion",
        .source_kms_key_arn = "SourceKMSKeyArn",
        .zip_file = "ZipFile",
    };
};

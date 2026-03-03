/// The code for the Lambda function. You can specify either an object in Amazon
/// S3, or upload a deployment package directly.
pub const AwsLambdaFunctionCode = struct {
    /// An Amazon S3 bucket in the same Amazon Web Services Region as your function.
    /// The bucket can be in a different Amazon Web Services account.
    s3_bucket: ?[]const u8 = null,

    /// The Amazon S3 key of the deployment package.
    s3_key: ?[]const u8 = null,

    /// For versioned objects, the version of the deployment package object to use.
    s3_object_version: ?[]const u8 = null,

    /// The base64-encoded contents of the deployment package. Amazon Web Services
    /// SDK and Amazon Web Services CLI clients handle the encoding for you.
    zip_file: ?[]const u8 = null,

    pub const json_field_names = .{
        .s3_bucket = "S3Bucket",
        .s3_key = "S3Key",
        .s3_object_version = "S3ObjectVersion",
        .zip_file = "ZipFile",
    };
};

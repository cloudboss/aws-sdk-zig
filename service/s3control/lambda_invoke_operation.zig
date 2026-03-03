const aws = @import("aws");

/// Contains the configuration parameters for a `Lambda Invoke` operation.
pub const LambdaInvokeOperation = struct {
    /// The Amazon Resource Name (ARN) for the Lambda function that the specified
    /// job will
    /// invoke on every object in the manifest.
    function_arn: ?[]const u8 = null,

    /// Specifies the schema version for the payload that Batch Operations sends
    /// when invoking
    /// an Lambda function. Version `1.0` is the default. Version
    /// `2.0` is required when you use Batch Operations to invoke Lambda functions
    /// that act on directory buckets, or if you need to specify
    /// `UserArguments`. For more information, see [Automate object processing in
    /// Amazon S3 directory buckets with S3 Batch Operations and
    /// Lambda](https://aws.amazon.com/blogs/storage/automate-object-processing-in-amazon-s3-directory-buckets-with-s3-batch-operations-and-aws-lambda/) in the *Amazon Web Services Storage Blog*.
    ///
    /// Ensure that your Lambda function code expects
    /// `InvocationSchemaVersion`
    /// **2.0** and uses bucket name rather than bucket ARN. If the
    /// `InvocationSchemaVersion` does not match what your Lambda
    /// function expects, your function might not work as expected.
    ///
    /// **Directory buckets** - To initiate Amazon Web Services Lambda function to
    /// perform custom actions on objects in directory buckets, you must specify
    /// `2.0`.
    invocation_schema_version: ?[]const u8 = null,

    /// Key-value pairs that are passed in the payload that Batch Operations sends
    /// when invoking
    /// an Lambda function. You must specify `InvocationSchemaVersion`
    /// **2.0** for `LambdaInvoke` operations that include
    /// `UserArguments`. For more information, see [Automate object processing in
    /// Amazon S3 directory buckets with S3 Batch Operations and
    /// Lambda](https://aws.amazon.com/blogs/storage/automate-object-processing-in-amazon-s3-directory-buckets-with-s3-batch-operations-and-aws-lambda/) in the *Amazon Web Services Storage Blog*.
    user_arguments: ?[]const aws.map.StringMapEntry = null,
};

/// Represents an update to the
/// [InputLambdaProcessor](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/API_InputLambdaProcessor.html) that is used to preprocess the records in the stream.
pub const InputLambdaProcessorUpdate = struct {
    /// The Amazon Resource Name (ARN) of the new [AWS
    /// Lambda](https://docs.aws.amazon.com/lambda/) function that
    /// is used to preprocess the records in the stream.
    ///
    /// To specify an earlier version of the Lambda function than the latest,
    /// include the Lambda function version in the Lambda function ARN. For more
    /// information about Lambda ARNs, see [Example ARNs: AWS
    /// Lambda](/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-lambda)
    resource_arn_update: ?[]const u8 = null,

    /// The ARN of the new IAM role that is used to access the AWS Lambda
    /// function.
    role_arn_update: ?[]const u8 = null,

    pub const json_field_names = .{
        .resource_arn_update = "ResourceARNUpdate",
        .role_arn_update = "RoleARNUpdate",
    };
};

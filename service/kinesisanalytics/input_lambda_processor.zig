/// An object that contains the Amazon Resource Name (ARN) of the [AWS
/// Lambda](https://docs.aws.amazon.com/lambda/) function that
/// is used to preprocess records in the stream, and the ARN of the IAM role
/// that is used to
/// access the AWS Lambda function.
pub const InputLambdaProcessor = struct {
    /// The ARN of the [AWS Lambda](https://docs.aws.amazon.com/lambda/) function
    /// that operates
    /// on records in the stream.
    ///
    /// To specify an earlier version of the Lambda function than the latest,
    /// include the Lambda function version in the Lambda function ARN. For more
    /// information about Lambda ARNs, see [Example ARNs: AWS
    /// Lambda](/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-lambda)
    resource_arn: []const u8,

    /// The ARN of the IAM role that is used to access the AWS Lambda function.
    role_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .role_arn = "RoleARN",
    };
};

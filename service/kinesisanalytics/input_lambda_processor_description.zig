/// An object that contains the Amazon Resource Name (ARN) of the [AWS
/// Lambda](https://docs.aws.amazon.com/lambda/) function that
/// is used to preprocess records in the stream, and the ARN of the IAM role
/// that is used
/// to access the AWS Lambda expression.
pub const InputLambdaProcessorDescription = struct {
    /// The ARN of the [AWS Lambda](https://docs.aws.amazon.com/lambda/) function
    /// that is used to preprocess the records in the stream.
    resource_arn: ?[]const u8,

    /// The ARN of the IAM role that is used to access the AWS Lambda function.
    role_arn: ?[]const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .role_arn = "RoleARN",
    };
};

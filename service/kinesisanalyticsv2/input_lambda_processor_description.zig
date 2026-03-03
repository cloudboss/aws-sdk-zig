/// For a SQL-based Kinesis Data Analytics application, an object that contains
/// the
/// Amazon Resource Name (ARN) of the Amazon Lambda function that is used to
/// preprocess records in
/// the stream.
pub const InputLambdaProcessorDescription = struct {
    /// The ARN of the Amazon Lambda function that is used to preprocess the records
    /// in the
    /// stream.
    ///
    /// To specify an earlier version of the Lambda function than the latest,
    /// include the Lambda function version in the Lambda function ARN. For more
    /// information about Lambda ARNs, see [Example ARNs: Amazon
    /// Lambda](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-lambda)
    resource_arn: []const u8,

    /// The ARN of the IAM role that is used to access the Amazon Lambda function.
    ///
    /// Provided for backward compatibility. Applications that are created with the
    /// current API
    /// version have an application-level service execution role rather than a
    /// resource-level
    /// role.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .role_arn = "RoleARN",
    };
};

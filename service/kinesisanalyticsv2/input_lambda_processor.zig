/// An object that contains the Amazon Resource Name (ARN) of the Amazon Lambda
/// function that is
/// used to preprocess records in the stream in a SQL-based Kinesis Data
/// Analytics application.
pub const InputLambdaProcessor = struct {
    /// The ARN of the Amazon Lambda function that operates on records in the
    /// stream.
    ///
    /// To specify an earlier version of the Lambda function than the latest,
    /// include the Lambda function version in the Lambda function ARN. For more
    /// information about Lambda ARNs, see [Example ARNs: Amazon
    /// Lambda](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-lambda)
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
    };
};

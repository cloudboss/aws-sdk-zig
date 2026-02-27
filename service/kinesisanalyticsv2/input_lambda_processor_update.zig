/// For a SQL-based Kinesis Data Analytics application, represents an update to
/// the
/// InputLambdaProcessor that is used to preprocess the records in the
/// stream.
pub const InputLambdaProcessorUpdate = struct {
    /// The Amazon Resource Name (ARN) of the new Amazon Lambda function that is
    /// used to preprocess
    /// the records in the stream.
    ///
    /// To specify an earlier version of the Lambda function than the latest,
    /// include the Lambda function version in the Lambda function ARN. For more
    /// information about Lambda ARNs, see [Example ARNs: Amazon
    /// Lambda](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-lambda)
    resource_arn_update: []const u8,

    pub const json_field_names = .{
        .resource_arn_update = "ResourceARNUpdate",
    };
};

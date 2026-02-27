/// When you update an SQL-based Kinesis Data Analytics application's output
/// configuration using the UpdateApplication operation, provides information
/// about an Amazon Lambda function that is configured as the destination.
pub const LambdaOutputUpdate = struct {
    /// The Amazon Resource Name (ARN) of the destination Amazon Lambda function.
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

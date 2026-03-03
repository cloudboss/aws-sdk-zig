/// When updating an output configuration using the
/// [UpdateApplication](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/API_UpdateApplication.html)
/// operation, provides information about an AWS Lambda function configured as
/// the
/// destination.
pub const LambdaOutputUpdate = struct {
    /// Amazon Resource Name (ARN) of the destination Lambda function.
    ///
    /// To specify an earlier version of the Lambda function than the latest,
    /// include the Lambda function version in the Lambda function ARN. For more
    /// information about Lambda ARNs, see [Example ARNs: AWS
    /// Lambda](/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-lambda)
    resource_arn_update: ?[]const u8 = null,

    /// ARN of the IAM role that Amazon Kinesis Analytics can assume to write to the
    /// destination function on your behalf. You need to grant the necessary
    /// permissions to this role.
    role_arn_update: ?[]const u8 = null,

    pub const json_field_names = .{
        .resource_arn_update = "ResourceARNUpdate",
        .role_arn_update = "RoleARNUpdate",
    };
};

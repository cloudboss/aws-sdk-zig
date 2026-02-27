/// When configuring application output, identifies an AWS Lambda function as
/// the
/// destination. You provide the function Amazon Resource Name (ARN) and also an
/// IAM role
/// ARN that Amazon Kinesis Analytics can use to write to the function on your
/// behalf.
pub const LambdaOutput = struct {
    /// Amazon Resource Name (ARN) of the destination Lambda function to write
    /// to.
    ///
    /// To specify an earlier version of the Lambda function than the latest,
    /// include the Lambda function version in the Lambda function ARN. For more
    /// information about Lambda ARNs, see [Example ARNs: AWS
    /// Lambda](/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-lambda)
    resource_arn: []const u8,

    /// ARN of the IAM role that Amazon Kinesis Analytics can assume to write to the
    /// destination function on your behalf. You need to grant the necessary
    /// permissions to this role.
    role_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .role_arn = "RoleARN",
    };
};

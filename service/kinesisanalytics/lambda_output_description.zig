/// For an application output, describes the AWS Lambda function configured as
/// its
/// destination.
pub const LambdaOutputDescription = struct {
    /// Amazon Resource Name (ARN) of the destination Lambda function.
    resource_arn: ?[]const u8 = null,

    /// ARN of the IAM role that Amazon Kinesis Analytics can assume to write to the
    /// destination function.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .role_arn = "RoleARN",
    };
};

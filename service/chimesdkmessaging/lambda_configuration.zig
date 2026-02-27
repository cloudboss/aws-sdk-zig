const InvocationType = @import("invocation_type.zig").InvocationType;

/// Stores metadata about a Lambda processor.
pub const LambdaConfiguration = struct {
    /// Controls how the Lambda function is invoked.
    invocation_type: InvocationType,

    /// The ARN of the Lambda message processing function.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .invocation_type = "InvocationType",
        .resource_arn = "ResourceArn",
    };
};

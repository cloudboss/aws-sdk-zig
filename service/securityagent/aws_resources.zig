const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// The AWS resources associated with an agent space, including VPCs, log
/// groups, S3 buckets, secrets, Lambda functions, and IAM roles.
pub const AWSResources = struct {
    /// The IAM roles associated with the agent space.
    iam_roles: ?[]const []const u8 = null,

    /// The Amazon Resource Names (ARNs) of the Lambda functions associated with the
    /// agent space.
    lambda_function_arns: ?[]const []const u8 = null,

    /// The Amazon Resource Names (ARNs) of the CloudWatch log groups associated
    /// with the agent space.
    log_groups: ?[]const []const u8 = null,

    /// The Amazon Resource Names (ARNs) of the S3 buckets associated with the agent
    /// space.
    s_3_buckets: ?[]const []const u8 = null,

    /// The Amazon Resource Names (ARNs) of the Secrets Manager secrets associated
    /// with the agent space.
    secret_arns: ?[]const []const u8 = null,

    /// The VPC configurations associated with the agent space.
    vpcs: ?[]const VpcConfig = null,

    pub const json_field_names = .{
        .iam_roles = "iamRoles",
        .lambda_function_arns = "lambdaFunctionArns",
        .log_groups = "logGroups",
        .s_3_buckets = "s3Buckets",
        .secret_arns = "secretArns",
        .vpcs = "vpcs",
    };
};

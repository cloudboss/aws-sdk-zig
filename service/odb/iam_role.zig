const SupportedAwsIntegration = @import("supported_aws_integration.zig").SupportedAwsIntegration;
const IamRoleStatus = @import("iam_role_status.zig").IamRoleStatus;

/// Information about an Amazon Web Services Identity and Access Management
/// (IAM) service role associated with a resource.
pub const IamRole = struct {
    /// The Amazon Web Services integration configuration settings for the Amazon
    /// Web Services Identity and Access Management (IAM) service role.
    aws_integration: ?SupportedAwsIntegration = null,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services Identity and
    /// Access Management (IAM) service role.
    iam_role_arn: ?[]const u8 = null,

    /// The current status of the Amazon Web Services Identity and Access Management
    /// (IAM) service role.
    status: ?IamRoleStatus = null,

    /// Additional information about the current status of the Amazon Web Services
    /// Identity and Access Management (IAM) service role, if applicable.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_integration = "awsIntegration",
        .iam_role_arn = "iamRoleArn",
        .status = "status",
        .status_reason = "statusReason",
    };
};

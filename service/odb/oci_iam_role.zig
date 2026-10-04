const OciAwsIntegration = @import("oci_aws_integration.zig").OciAwsIntegration;
const OciIamRoleStatus = @import("oci_iam_role_status.zig").OciIamRoleStatus;

/// Information about an Amazon Web Services Identity and Access Management
/// (IAM) service role used for Autonomous Database integration with Oracle
/// Cloud Infrastructure (OCI).
pub const OciIamRole = struct {
    /// The Amazon Web Services integration configuration settings for the Amazon
    /// Web Services Identity and Access Management (IAM) service role.
    aws_integration: ?OciAwsIntegration = null,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services Identity and
    /// Access Management (IAM) service role.
    iam_role_arn: ?[]const u8 = null,

    /// The current lifecycle status of the IAM service role.
    status: ?OciIamRoleStatus = null,

    /// Additional information about the current status of the IAM service role, if
    /// applicable.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_integration = "awsIntegration",
        .iam_role_arn = "iamRoleArn",
        .status = "status",
        .status_reason = "statusReason",
    };
};

const MonitorAccountType = @import("monitor_account_type.zig").MonitorAccountType;
const ValidationStatus = @import("validation_status.zig").ValidationStatus;

/// Configuration for AWS monitor account integration, allowing AIDevOps to
/// monitor AWS resources.
pub const AWSConfiguration = struct {
    /// AWS Account Id corresponding to provided resources.
    account_id: []const u8,

    /// Account Type 'monitor' for AIDevOps monitoring.
    account_type: MonitorAccountType,

    /// Optional IAM role ARN to be assumed by AIDevOps for elevated directed
    /// actions on behalf of the customer. Used for mutating operations gated by
    /// elevatedActionsEnabled on the AgentSpace. When not provided, only
    /// non-elevated directed actions are available for this AWS account.
    agent_elevated_role_arn: ?[]const u8 = null,

    /// Validation status of the agentElevatedRoleArn. Updated asynchronously after
    /// the customer registers an elevated role. Possible values:
    /// PENDING_CONFIRMATION (validation in progress), VALID (role validated),
    /// INVALID (validation failed).
    agent_elevated_role_arn_status: ?ValidationStatus = null,

    /// Role ARN to be assumed by AIDevOps to operate on behalf of customer.
    assumable_role_arn: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .account_type = "accountType",
        .agent_elevated_role_arn = "agentElevatedRoleArn",
        .agent_elevated_role_arn_status = "agentElevatedRoleArnStatus",
        .assumable_role_arn = "assumableRoleArn",
    };
};

const SourceAccountType = @import("source_account_type.zig").SourceAccountType;
const ValidationStatus = @import("validation_status.zig").ValidationStatus;

/// Configuration for AWS source account integration. Setting the role ARNs on
/// this configuration requires the caller to have at least the iam:PassRole
/// permission (see assumableRoleArn).
pub const SourceAwsConfiguration = struct {
    /// AWS Account Id corresponding to provided resources.
    account_id: []const u8,

    /// Account Type 'source' for AIDevOps monitoring.
    account_type: SourceAccountType,

    /// Optional IAM role ARN to be assumed by AIDevOps for elevated directed
    /// actions on behalf of the customer. Used for mutating operations gated by
    /// elevatedActionsEnabled on the AgentSpace. When not provided, only
    /// non-elevated directed actions are available for this AWS account. Setting
    /// this role is subject to the same minimum iam:PassRole requirement described
    /// on assumableRoleArn.
    agent_elevated_role_arn: ?[]const u8 = null,

    /// Validation status of the agentElevatedRoleArn. Updated asynchronously after
    /// the customer registers an elevated role. Possible values:
    /// PENDING_CONFIRMATION (validation in progress), VALID (role validated),
    /// INVALID (validation failed).
    agent_elevated_role_arn_status: ?ValidationStatus = null,

    /// Role ARN to be assumed by AIDevOps to operate on behalf of customer. To set
    /// this role ARN on AssociateService or UpdateAssociation, the caller must have
    /// at least the iam:PassRole permission on arn:aws:iam::<account-id>:role/* in
    /// the caller's own account, with the condition iam:PassedToService set to
    /// aidevops.amazonaws.com. A broader iam:PassRole grant also satisfies this
    /// requirement.
    assumable_role_arn: []const u8,

    /// External ID for additional security when assuming the role. Used to prevent
    /// the confused deputy problem.
    external_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .account_type = "accountType",
        .agent_elevated_role_arn = "agentElevatedRoleArn",
        .agent_elevated_role_arn_status = "agentElevatedRoleArnStatus",
        .assumable_role_arn = "assumableRoleArn",
        .external_id = "externalId",
    };
};

const ApproverLastActivity = @import("approver_last_activity.zig").ApproverLastActivity;
const MfaMethod = @import("mfa_method.zig").MfaMethod;
const IdentityStatus = @import("identity_status.zig").IdentityStatus;

/// Contains details for an approver.
pub const GetApprovalTeamResponseApprover = struct {
    /// ID for the approver.
    approver_id: ?[]const u8 = null,

    /// Last Activity performed by the approver.
    last_activity: ?ApproverLastActivity = null,

    /// Timestamp when the approver last responded to an operation or invitation
    /// request.
    last_activity_time: ?i64 = null,

    /// Multi-factor authentication configuration for the approver
    mfa_methods: ?[]const MfaMethod = null,

    /// Amazon Resource Name (ARN) for the pending baseline session.
    pending_baseline_session_arn: ?[]const u8 = null,

    /// ID for the user.
    primary_identity_id: ?[]const u8 = null,

    /// Amazon Resource Name (ARN) for the identity source. The identity source
    /// manages the user authentication for approvers.
    primary_identity_source_arn: ?[]const u8 = null,

    /// Status for the identity source. For example, if an approver has accepted a
    /// team invitation with a user authentication method managed by the identity
    /// source.
    primary_identity_status: ?IdentityStatus = null,

    /// Timestamp when the approver responded to an approval team invitation.
    response_time: ?i64 = null,

    pub const json_field_names = .{
        .approver_id = "ApproverId",
        .last_activity = "LastActivity",
        .last_activity_time = "LastActivityTime",
        .mfa_methods = "MfaMethods",
        .pending_baseline_session_arn = "PendingBaselineSessionArn",
        .primary_identity_id = "PrimaryIdentityId",
        .primary_identity_source_arn = "PrimaryIdentitySourceArn",
        .primary_identity_status = "PrimaryIdentityStatus",
        .response_time = "ResponseTime",
    };
};

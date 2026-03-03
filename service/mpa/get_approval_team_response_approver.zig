const MfaMethod = @import("mfa_method.zig").MfaMethod;
const IdentityStatus = @import("identity_status.zig").IdentityStatus;

/// Contains details for an approver.
pub const GetApprovalTeamResponseApprover = struct {
    /// ID for the approver.
    approver_id: ?[]const u8 = null,

    /// Multi-factor authentication configuration for the approver
    mfa_methods: ?[]const MfaMethod = null,

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
        .mfa_methods = "MfaMethods",
        .primary_identity_id = "PrimaryIdentityId",
        .primary_identity_source_arn = "PrimaryIdentitySourceArn",
        .primary_identity_status = "PrimaryIdentityStatus",
        .response_time = "ResponseTime",
    };
};

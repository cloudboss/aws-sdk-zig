/// Contains details for an approver.
pub const ApprovalTeamRequestApprover = struct {
    /// ID for the user.
    primary_identity_id: []const u8,

    /// Amazon Resource Name (ARN) for the identity source. The identity source
    /// manages the user authentication for approvers.
    primary_identity_source_arn: []const u8,

    pub const json_field_names = .{
        .primary_identity_id = "PrimaryIdentityId",
        .primary_identity_source_arn = "PrimaryIdentitySourceArn",
    };
};

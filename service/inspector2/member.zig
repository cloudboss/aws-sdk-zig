const RelationshipStatus = @import("relationship_status.zig").RelationshipStatus;

/// Details on a member account in your organization.
pub const Member = struct {
    /// The Amazon Web Services account ID of the member account.
    account_id: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the Amazon Inspector delegated
    /// administrator for this member
    /// account.
    delegated_admin_account_id: ?[]const u8 = null,

    /// The status of the member account.
    relationship_status: ?RelationshipStatus = null,

    /// A timestamp showing when the status of this member was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .delegated_admin_account_id = "delegatedAdminAccountId",
        .relationship_status = "relationshipStatus",
        .updated_at = "updatedAt",
    };
};

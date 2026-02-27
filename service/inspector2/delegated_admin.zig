const RelationshipStatus = @import("relationship_status.zig").RelationshipStatus;

/// Details of the Amazon Inspector delegated administrator for your
/// organization.
pub const DelegatedAdmin = struct {
    /// The Amazon Web Services account ID of the Amazon Inspector delegated
    /// administrator for your organization.
    account_id: ?[]const u8,

    /// The status of the Amazon Inspector delegated administrator.
    relationship_status: ?RelationshipStatus,

    pub const json_field_names = .{
        .account_id = "accountId",
        .relationship_status = "relationshipStatus",
    };
};

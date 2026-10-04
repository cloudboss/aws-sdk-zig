const DocumentAclMembershipType = @import("document_acl_membership_type.zig").DocumentAclMembershipType;

/// A user entry within a document access control list (ACL) condition.
pub const DocumentAclUser = struct {
    /// The identifier of the user.
    id: []const u8,

    /// The membership type indicating the scope of the user entry.
    @"type": DocumentAclMembershipType,

    pub const json_field_names = .{
        .id = "id",
        .@"type" = "type",
    };
};

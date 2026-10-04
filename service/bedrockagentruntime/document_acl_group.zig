const DocumentAclMembershipType = @import("document_acl_membership_type.zig").DocumentAclMembershipType;

/// A group entry within a document access control list (ACL) condition.
pub const DocumentAclGroup = struct {
    /// The identifier of the group.
    id: []const u8,

    /// The membership type indicating the scope of the group entry.
    @"type": DocumentAclMembershipType,

    pub const json_field_names = .{
        .id = "id",
        .@"type" = "type",
    };
};

const MembershipType = @import("membership_type.zig").MembershipType;

/// Represents a user in the document's ACL, used to define access permissions
/// for individual users.
pub const DocumentAclUser = struct {
    /// The unique identifier of the user in the document's ACL. This is used to
    /// identify the user when applying access rules.
    id: ?[]const u8,

    /// The type of the user. This indicates the scope of the user's applicability
    /// in access control.
    @"type": ?MembershipType,

    pub const json_field_names = .{
        .id = "id",
        .@"type" = "type",
    };
};

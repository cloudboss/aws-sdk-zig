const MembershipType = @import("membership_type.zig").MembershipType;

/// Represents a group in the document's ACL, used to define access permissions
/// for multiple users collectively.
pub const DocumentAclGroup = struct {
    /// The name of the group in the document's ACL. This is used to identify the
    /// group when applying access rules.
    name: ?[]const u8,

    /// The type of the group. This indicates the scope of the group's applicability
    /// in access control.
    type: ?MembershipType,

    pub const json_field_names = .{
        .name = "name",
        .type = "type",
    };
};

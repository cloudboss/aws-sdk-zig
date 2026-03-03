const MembershipType = @import("membership_type.zig").MembershipType;

/// Represents a group associated with a given user in the access control
/// system.
pub const AssociatedGroup = struct {
    /// The name of the group associated with the user. This is used to identify the
    /// group in access control decisions.
    name: ?[]const u8 = null,

    /// The type of the associated group. This indicates the scope of the group's
    /// applicability.
    @"type": ?MembershipType = null,

    pub const json_field_names = .{
        .name = "name",
        .@"type" = "type",
    };
};

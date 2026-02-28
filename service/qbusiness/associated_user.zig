const MembershipType = @import("membership_type.zig").MembershipType;

/// Represents an associated user in the access control system.
pub const AssociatedUser = struct {
    /// The unique identifier of the associated user. This is used to identify the
    /// user in access control decisions.
    id: ?[]const u8,

    /// The type of the associated user. This indicates the scope of the user's
    /// association.
    @"type": ?MembershipType,

    pub const json_field_names = .{
        .id = "id",
        .@"type" = "type",
    };
};

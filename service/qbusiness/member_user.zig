const MembershipType = @import("membership_type.zig").MembershipType;

/// The users that belong to a group.
pub const MemberUser = struct {
    /// The type of the user.
    type: ?MembershipType,

    /// The identifier of the user you want to map to a group.
    user_id: []const u8,

    pub const json_field_names = .{
        .type = "type",
        .user_id = "userId",
    };
};

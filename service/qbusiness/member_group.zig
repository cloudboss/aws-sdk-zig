const MembershipType = @import("membership_type.zig").MembershipType;

/// The sub groups that belong to a group.
pub const MemberGroup = struct {
    /// The name of the sub group.
    group_name: []const u8,

    /// The type of the sub group.
    type: ?MembershipType,

    pub const json_field_names = .{
        .group_name = "groupName",
        .type = "type",
    };
};

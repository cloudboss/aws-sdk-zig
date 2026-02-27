const GroupDetails = @import("group_details.zig").GroupDetails;
const UserDetails = @import("user_details.zig").UserDetails;

/// The details about a project member.
pub const MemberDetails = union(enum) {
    /// The group details of a project member.
    group: ?GroupDetails,
    /// The user details of a project member.
    user: ?UserDetails,

    pub const json_field_names = .{
        .group = "group",
        .user = "user",
    };
};

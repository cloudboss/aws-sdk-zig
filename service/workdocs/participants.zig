const GroupMetadata = @import("group_metadata.zig").GroupMetadata;
const UserMetadata = @import("user_metadata.zig").UserMetadata;

/// Describes the users or user groups.
pub const Participants = struct {
    /// The list of user groups.
    groups: ?[]const GroupMetadata = null,

    /// The list of users.
    users: ?[]const UserMetadata = null,

    pub const json_field_names = .{
        .groups = "Groups",
        .users = "Users",
    };
};

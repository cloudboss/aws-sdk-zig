/// Provides information about users and group names associated with a topic
/// control rule.
pub const UsersAndGroups = struct {
    /// The user group names associated with a topic control rule.
    user_groups: ?[]const []const u8 = null,

    /// The user ids associated with a topic control rule.
    user_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .user_groups = "userGroups",
        .user_ids = "userIds",
    };
};

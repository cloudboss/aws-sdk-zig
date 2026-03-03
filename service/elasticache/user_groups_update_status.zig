/// The status of the user group update.
pub const UserGroupsUpdateStatus = struct {
    /// The ID of the user group to add.
    user_group_ids_to_add: ?[]const []const u8 = null,

    /// The ID of the user group to remove.
    user_group_ids_to_remove: ?[]const []const u8 = null,
};

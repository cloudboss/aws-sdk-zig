/// Returns the updates being applied to the user group.
pub const UserGroupPendingChanges = struct {
    /// The list of user IDs to add.
    user_ids_to_add: ?[]const []const u8,

    /// The list of user IDs to remove.
    user_ids_to_remove: ?[]const []const u8,
};

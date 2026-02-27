/// Returns the updates being applied to the ACL.
pub const ACLPendingChanges = struct {
    /// A list of users being added to the ACL
    user_names_to_add: ?[]const []const u8,

    /// A list of user names being removed from the ACL
    user_names_to_remove: ?[]const []const u8,

    pub const json_field_names = .{
        .user_names_to_add = "UserNamesToAdd",
        .user_names_to_remove = "UserNamesToRemove",
    };
};

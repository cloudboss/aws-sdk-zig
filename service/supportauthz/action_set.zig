/// The set of actions authorized by a permit. Specify either all actions or a
/// list of specific actions.
pub const ActionSet = union(enum) {
    /// A list of specific support actions to authorize. Maximum of 10 actions.
    actions: ?[]const []const u8,
    /// Authorizes all available support actions.
    all_actions: ?struct {},

    pub const json_field_names = .{
        .actions = "actions",
        .all_actions = "allActions",
    };
};

/// Resource launch actions filter.
pub const LaunchActionsRequestFilters = struct {
    /// Launch actions Ids.
    action_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .action_ids = "actionIds",
    };
};

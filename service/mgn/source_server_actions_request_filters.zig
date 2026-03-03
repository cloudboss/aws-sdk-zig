/// Source server post migration custom action filters.
pub const SourceServerActionsRequestFilters = struct {
    /// Action IDs to filter source server post migration custom actions by.
    action_i_ds: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .action_i_ds = "actionIDs",
    };
};

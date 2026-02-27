/// Template post migration custom action filters.
pub const TemplateActionsRequestFilters = struct {
    /// Action IDs to filter template post migration custom actions by.
    action_i_ds: ?[]const []const u8,

    pub const json_field_names = .{
        .action_i_ds = "actionIDs",
    };
};

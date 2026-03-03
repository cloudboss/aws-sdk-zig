const ActionFilter = @import("action_filter.zig").ActionFilter;

/// Enables filtering of results based on specified action criteria. You can
/// define multiple action filters to refine results using combinations of
/// feature type, severity level, and recommendation type.
pub const RequestFilter = struct {
    /// A list of action filters that define criteria for filtering results. Each
    /// filter specifies a key, match option, and corresponding values to filter on.
    actions: ?[]const ActionFilter = null,

    pub const json_field_names = .{
        .actions = "actions",
    };
};

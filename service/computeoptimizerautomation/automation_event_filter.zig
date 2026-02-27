const AutomationEventFilterName = @import("automation_event_filter_name.zig").AutomationEventFilterName;

/// A filter to apply when listing automation events.
pub const AutomationEventFilter = struct {
    /// The name of the filter to apply.
    name: AutomationEventFilterName,

    /// The values to use for the specified filter.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};

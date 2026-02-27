const ScheduledActionFilterName = @import("scheduled_action_filter_name.zig").ScheduledActionFilterName;

/// A set of elements to filter the returned scheduled actions.
pub const ScheduledActionFilter = struct {
    /// The type of element to filter.
    name: ScheduledActionFilterName,

    /// List of values. Compare if the value (of type defined by `Name`) equals an
    /// item in the list of scheduled actions.
    values: []const []const u8,
};

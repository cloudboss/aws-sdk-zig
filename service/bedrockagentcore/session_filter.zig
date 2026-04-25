const EventFilterCondition = @import("event_filter_condition.zig").EventFilterCondition;

/// Contains filter criteria for listing sessions.
pub const SessionFilter = struct {
    /// The event filter condition to apply. Use this to filter sessions based on
    /// event presence.
    event_filter: ?EventFilterCondition = null,

    pub const json_field_names = .{
        .event_filter = "eventFilter",
    };
};

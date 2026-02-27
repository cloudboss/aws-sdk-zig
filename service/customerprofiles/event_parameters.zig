/// Configuration parameters for events in the personalization system.
pub const EventParameters = struct {
    /// The type of event being tracked (e.g., 'click', 'purchase', 'view').
    event_type: []const u8,

    /// The minimum value threshold that an event must meet to be considered valid.
    event_value_threshold: ?f64,

    pub const json_field_names = .{
        .event_type = "EventType",
        .event_value_threshold = "EventValueThreshold",
    };
};

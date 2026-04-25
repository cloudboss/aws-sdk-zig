/// Configuration parameters for events in the personalization system.
pub const EventParameters = struct {
    /// The type of event being tracked (e.g., 'click', 'purchase', 'view').
    event_type: []const u8,

    /// The minimum value threshold that an event must meet to be considered valid.
    event_value_threshold: ?f64 = null,

    /// The weight of the event type. A higher weight means higher importance of the
    /// event type for the created solution.
    event_weight: ?f64 = null,

    pub const json_field_names = .{
        .event_type = "EventType",
        .event_value_threshold = "EventValueThreshold",
        .event_weight = "EventWeight",
    };
};

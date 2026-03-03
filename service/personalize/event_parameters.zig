/// Describes the parameters of events, which are used in solution creation.
pub const EventParameters = struct {
    /// The name of the event type to be considered for solution creation.
    event_type: ?[]const u8 = null,

    /// The threshold of the event type. Only events with a value greater or equal
    /// to this threshold will be considered for solution creation.
    event_value_threshold: ?f64 = null,

    /// The weight of the event type. A higher weight means higher importance of the
    /// event type for the created solution.
    weight: ?f64 = null,

    pub const json_field_names = .{
        .event_type = "eventType",
        .event_value_threshold = "eventValueThreshold",
        .weight = "weight",
    };
};

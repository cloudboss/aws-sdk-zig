pub const EventSourcePosition = enum {
    trim_horizon,
    latest,
    at_timestamp,

    pub const json_field_names = .{
        .trim_horizon = "TRIM_HORIZON",
        .latest = "LATEST",
        .at_timestamp = "AT_TIMESTAMP",
    };
};

pub const StartingPosition = enum {
    latest,
    trim_horizon,
    earliest,
    timestamp,

    pub const json_field_names = .{
        .latest = "LATEST",
        .trim_horizon = "TRIM_HORIZON",
        .earliest = "EARLIEST",
        .timestamp = "TIMESTAMP",
    };
};

pub const InputStartingPosition = enum {
    now,
    trim_horizon,
    last_stopped_point,

    pub const json_field_names = .{
        .now = "NOW",
        .trim_horizon = "TRIM_HORIZON",
        .last_stopped_point = "LAST_STOPPED_POINT",
    };
};

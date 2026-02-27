pub const LaunchStopDesiredState = enum {
    completed,
    cancelled,

    pub const json_field_names = .{
        .completed = "COMPLETED",
        .cancelled = "CANCELLED",
    };
};

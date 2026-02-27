pub const CisTargetStatus = enum {
    timed_out,
    cancelled,
    completed,

    pub const json_field_names = .{
        .timed_out = "TIMED_OUT",
        .cancelled = "CANCELLED",
        .completed = "COMPLETED",
    };
};

pub const ClockTargetStatus = enum {
    unknown,
    started,
    stopped,

    pub const json_field_names = .{
        .unknown = "UNKNOWN",
        .started = "STARTED",
        .stopped = "STOPPED",
    };
};

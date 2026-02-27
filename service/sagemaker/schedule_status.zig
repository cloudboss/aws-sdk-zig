pub const ScheduleStatus = enum {
    pending,
    failed,
    scheduled,
    stopped,

    pub const json_field_names = .{
        .pending = "PENDING",
        .failed = "FAILED",
        .scheduled = "SCHEDULED",
        .stopped = "STOPPED",
    };
};

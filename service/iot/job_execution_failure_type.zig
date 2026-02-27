pub const JobExecutionFailureType = enum {
    failed,
    rejected,
    timed_out,
    all,

    pub const json_field_names = .{
        .failed = "FAILED",
        .rejected = "REJECTED",
        .timed_out = "TIMED_OUT",
        .all = "ALL",
    };
};

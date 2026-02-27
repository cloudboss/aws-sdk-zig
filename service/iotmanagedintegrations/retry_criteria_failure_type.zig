pub const RetryCriteriaFailureType = enum {
    failed,
    timed_out,
    all,

    pub const json_field_names = .{
        .failed = "FAILED",
        .timed_out = "TIMED_OUT",
        .all = "ALL",
    };
};

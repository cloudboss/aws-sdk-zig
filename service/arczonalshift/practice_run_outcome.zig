pub const PracticeRunOutcome = enum {
    failed,
    interrupted,
    pending,
    succeeded,
    capacity_check_failed,

    pub const json_field_names = .{
        .failed = "FAILED",
        .interrupted = "INTERRUPTED",
        .pending = "PENDING",
        .succeeded = "SUCCEEDED",
        .capacity_check_failed = "CAPACITY_CHECK_FAILED",
    };
};

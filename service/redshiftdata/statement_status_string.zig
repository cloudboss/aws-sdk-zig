pub const StatementStatusString = enum {
    submitted,
    picked,
    started,
    finished,
    aborted,
    failed,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .picked = "PICKED",
        .started = "STARTED",
        .finished = "FINISHED",
        .aborted = "ABORTED",
        .failed = "FAILED",
    };
};

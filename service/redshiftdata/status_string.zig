pub const StatusString = enum {
    submitted,
    picked,
    started,
    finished,
    aborted,
    failed,
    all,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .picked = "PICKED",
        .started = "STARTED",
        .finished = "FINISHED",
        .aborted = "ABORTED",
        .failed = "FAILED",
        .all = "ALL",
    };
};

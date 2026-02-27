pub const ResultStatus = enum {
    in_progress,
    completed,
    failed,
    expired,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .expired = "EXPIRED",
    };
};

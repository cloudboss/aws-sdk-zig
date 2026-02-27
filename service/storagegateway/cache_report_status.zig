pub const CacheReportStatus = enum {
    in_progress,
    completed,
    canceled,
    failed,
    @"error",

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .canceled = "CANCELED",
        .failed = "FAILED",
        .@"error" = "ERROR",
    };
};

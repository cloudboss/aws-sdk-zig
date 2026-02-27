pub const ContinuousExportStatus = enum {
    start_in_progress,
    start_failed,
    active,
    @"error",
    stop_in_progress,
    stop_failed,
    inactive,

    pub const json_field_names = .{
        .start_in_progress = "START_IN_PROGRESS",
        .start_failed = "START_FAILED",
        .active = "ACTIVE",
        .@"error" = "ERROR",
        .stop_in_progress = "STOP_IN_PROGRESS",
        .stop_failed = "STOP_FAILED",
        .inactive = "INACTIVE",
    };
};

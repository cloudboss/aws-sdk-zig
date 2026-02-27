pub const ReportStatus = enum {
    work_in_progress,
    failed,
    completed,

    pub const json_field_names = .{
        .work_in_progress = "WORK_IN_PROGRESS",
        .failed = "FAILED",
        .completed = "COMPLETED",
    };
};

pub const DetectMitigationActionExecutionStatus = enum {
    in_progress,
    successful,
    failed,
    skipped,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .successful = "SUCCESSFUL",
        .failed = "FAILED",
        .skipped = "SKIPPED",
    };
};

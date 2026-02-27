pub const DetectMitigationActionsTaskStatus = enum {
    in_progress,
    successful,
    failed,
    canceled,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .successful = "SUCCESSFUL",
        .failed = "FAILED",
        .canceled = "CANCELED",
    };
};

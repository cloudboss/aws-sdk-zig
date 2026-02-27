pub const AuditMitigationActionsTaskStatus = enum {
    in_progress,
    completed,
    failed,
    canceled,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .canceled = "CANCELED",
    };
};

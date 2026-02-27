pub const FlowOperationStatus = enum {
    completed,
    in_progress,
    failed,
    completed_with_errors,

    pub const json_field_names = .{
        .completed = "COMPLETED",
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
        .completed_with_errors = "COMPLETED_WITH_ERRORS",
    };
};

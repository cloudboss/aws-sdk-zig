pub const AssetBundleImportJobStatus = enum {
    queued_for_immediate_execution,
    in_progress,
    successful,
    failed,
    failed_rollback_in_progress,
    failed_rollback_completed,
    failed_rollback_error,

    pub const json_field_names = .{
        .queued_for_immediate_execution = "QUEUED_FOR_IMMEDIATE_EXECUTION",
        .in_progress = "IN_PROGRESS",
        .successful = "SUCCESSFUL",
        .failed = "FAILED",
        .failed_rollback_in_progress = "FAILED_ROLLBACK_IN_PROGRESS",
        .failed_rollback_completed = "FAILED_ROLLBACK_COMPLETED",
        .failed_rollback_error = "FAILED_ROLLBACK_ERROR",
    };
};

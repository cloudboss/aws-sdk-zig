pub const AssetBundleExportJobStatus = enum {
    queued_for_immediate_execution,
    in_progress,
    successful,
    failed,

    pub const json_field_names = .{
        .queued_for_immediate_execution = "QUEUED_FOR_IMMEDIATE_EXECUTION",
        .in_progress = "IN_PROGRESS",
        .successful = "SUCCESSFUL",
        .failed = "FAILED",
    };
};

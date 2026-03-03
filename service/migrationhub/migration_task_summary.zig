const Status = @import("status.zig").Status;

/// MigrationTaskSummary includes `MigrationTaskName`,
/// `ProgressPercent`, `ProgressUpdateStream`, `Status`,
/// and `UpdateDateTime` for each task.
pub const MigrationTaskSummary = struct {
    /// Unique identifier that references the migration task. *Do not store personal
    /// data in this field.*
    migration_task_name: ?[]const u8 = null,

    /// Indication of the percentage completion of the task.
    progress_percent: ?i32 = null,

    /// An AWS resource used for access control. It should uniquely identify the
    /// migration tool
    /// as it is used for all updates made by the tool.
    progress_update_stream: ?[]const u8 = null,

    /// Status of the task.
    status: ?Status = null,

    /// Detail information of what is being done within the overall status state.
    status_detail: ?[]const u8 = null,

    /// The timestamp when the task was gathered.
    update_date_time: ?i64 = null,

    pub const json_field_names = .{
        .migration_task_name = "MigrationTaskName",
        .progress_percent = "ProgressPercent",
        .progress_update_stream = "ProgressUpdateStream",
        .status = "Status",
        .status_detail = "StatusDetail",
        .update_date_time = "UpdateDateTime",
    };
};

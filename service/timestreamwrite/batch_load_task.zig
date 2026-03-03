const BatchLoadStatus = @import("batch_load_status.zig").BatchLoadStatus;

/// Details about a batch load task.
pub const BatchLoadTask = struct {
    /// The time when the Timestream batch load task was created.
    creation_time: ?i64 = null,

    /// Database name for the database into which a batch load task loads data.
    database_name: ?[]const u8 = null,

    /// The time when the Timestream batch load task was last updated.
    last_updated_time: ?i64 = null,

    resumable_until: ?i64 = null,

    /// Table name for the table into which a batch load task loads data.
    table_name: ?[]const u8 = null,

    /// The ID of the batch load task.
    task_id: ?[]const u8 = null,

    /// Status of the batch load task.
    task_status: ?BatchLoadStatus = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .database_name = "DatabaseName",
        .last_updated_time = "LastUpdatedTime",
        .resumable_until = "ResumableUntil",
        .table_name = "TableName",
        .task_id = "TaskId",
        .task_status = "TaskStatus",
    };
};

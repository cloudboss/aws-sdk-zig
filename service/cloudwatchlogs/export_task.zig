const ExportTaskExecutionInfo = @import("export_task_execution_info.zig").ExportTaskExecutionInfo;
const ExportTaskStatus = @import("export_task_status.zig").ExportTaskStatus;

/// Represents an export task.
pub const ExportTask = struct {
    /// The name of the S3 bucket to which the log data was exported.
    destination: ?[]const u8 = null,

    /// The prefix that was used as the start of Amazon S3 key for every object
    /// exported.
    destination_prefix: ?[]const u8 = null,

    /// Execution information about the export task.
    execution_info: ?ExportTaskExecutionInfo = null,

    /// The start time, expressed as the number of milliseconds after `Jan 1, 1970
    /// 00:00:00 UTC`. Events with a timestamp before this time are not exported.
    from: ?i64 = null,

    /// The name of the log group from which logs data was exported.
    log_group_name: ?[]const u8 = null,

    /// The status of the export task.
    status: ?ExportTaskStatus = null,

    /// The ID of the export task.
    task_id: ?[]const u8 = null,

    /// The name of the export task.
    task_name: ?[]const u8 = null,

    /// The end time, expressed as the number of milliseconds after `Jan 1, 1970
    /// 00:00:00
    /// UTC`. Events with a timestamp later than this time are not exported.
    to: ?i64 = null,

    pub const json_field_names = .{
        .destination = "destination",
        .destination_prefix = "destinationPrefix",
        .execution_info = "executionInfo",
        .from = "from",
        .log_group_name = "logGroupName",
        .status = "status",
        .task_id = "taskId",
        .task_name = "taskName",
        .to = "to",
    };
};

const DataSetTaskLifecycle = @import("data_set_task_lifecycle.zig").DataSetTaskLifecycle;
const DataSetImportSummary = @import("data_set_import_summary.zig").DataSetImportSummary;

/// Contains information about a data set import task.
pub const DataSetImportTask = struct {
    /// The status of the data set import task.
    status: DataSetTaskLifecycle,

    /// If dataset import failed, the failure reason will show here.
    status_reason: ?[]const u8 = null,

    /// A summary of the data set import task.
    summary: DataSetImportSummary,

    /// The identifier of the data set import task.
    task_id: []const u8,

    pub const json_field_names = .{
        .status = "status",
        .status_reason = "statusReason",
        .summary = "summary",
        .task_id = "taskId",
    };
};

const DataSetTaskLifecycle = @import("data_set_task_lifecycle.zig").DataSetTaskLifecycle;
const DataSetExportSummary = @import("data_set_export_summary.zig").DataSetExportSummary;

/// Contains information about a data set export task.
pub const DataSetExportTask = struct {
    /// The status of the data set export task.
    status: DataSetTaskLifecycle,

    /// If dataset exports failed, the failure reason will show here.
    status_reason: ?[]const u8,

    /// A summary of the data set export task.
    summary: DataSetExportSummary,

    /// The identifier of the data set export task.
    task_id: []const u8,

    pub const json_field_names = .{
        .status = "status",
        .status_reason = "statusReason",
        .summary = "summary",
        .task_id = "taskId",
    };
};

const ExportTaskStatusCode = @import("export_task_status_code.zig").ExportTaskStatusCode;

/// Represents the status of an export task.
pub const ExportTaskStatus = struct {
    /// The status code of the export task.
    code: ?ExportTaskStatusCode,

    /// The status message related to the status code.
    message: ?[]const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};

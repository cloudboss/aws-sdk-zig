const ExportErrorData = @import("export_error_data.zig").ExportErrorData;

/// Export task error.
pub const ExportTaskError = struct {
    /// Export task error data.
    error_data: ?ExportErrorData,

    /// Export task error datetime.
    error_date_time: ?[]const u8,

    pub const json_field_names = .{
        .error_data = "errorData",
        .error_date_time = "errorDateTime",
    };
};

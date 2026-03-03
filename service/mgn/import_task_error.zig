const ImportErrorData = @import("import_error_data.zig").ImportErrorData;
const ImportErrorType = @import("import_error_type.zig").ImportErrorType;

/// Import task error.
pub const ImportTaskError = struct {
    /// Import task error data.
    error_data: ?ImportErrorData = null,

    /// Import task error datetime.
    error_date_time: ?[]const u8 = null,

    /// Import task error type.
    error_type: ?ImportErrorType = null,

    pub const json_field_names = .{
        .error_data = "errorData",
        .error_date_time = "errorDateTime",
        .error_type = "errorType",
    };
};

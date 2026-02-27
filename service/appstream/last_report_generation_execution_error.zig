const UsageReportExecutionErrorCode = @import("usage_report_execution_error_code.zig").UsageReportExecutionErrorCode;

/// Describes the error that is returned when a usage report can't be generated.
pub const LastReportGenerationExecutionError = struct {
    /// The error code for the error that is returned when a usage report can't be
    /// generated.
    error_code: ?UsageReportExecutionErrorCode,

    /// The error message for the error that is returned when a usage report can't
    /// be generated.
    error_message: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
    };
};

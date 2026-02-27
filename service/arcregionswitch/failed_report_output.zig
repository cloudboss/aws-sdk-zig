const FailedReportErrorCode = @import("failed_report_error_code.zig").FailedReportErrorCode;

/// Information about a report generation that failed.
pub const FailedReportOutput = struct {
    /// The error code for the failed report generation.
    error_code: ?FailedReportErrorCode,

    /// The error message for the failed report generation.
    error_message: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
    };
};

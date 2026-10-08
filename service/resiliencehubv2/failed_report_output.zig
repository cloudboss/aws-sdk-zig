const ReportGenerationErrorCode = @import("report_generation_error_code.zig").ReportGenerationErrorCode;

/// Details when report generation failed.
pub const FailedReportOutput = struct {
    /// The error code describing why the report generation failed.
    error_code: ReportGenerationErrorCode,

    /// The error message describing why the report generation failed.
    error_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
    };
};

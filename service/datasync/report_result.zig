const PhaseStatus = @import("phase_status.zig").PhaseStatus;

/// Indicates whether DataSync created a complete [task
/// report](https://docs.aws.amazon.com/datasync/latest/userguide/task-reports.html) for your
/// transfer.
pub const ReportResult = struct {
    /// Indicates the code associated with the error if DataSync can't create a
    /// complete
    /// report.
    error_code: ?[]const u8,

    /// Provides details about issues creating a report.
    error_detail: ?[]const u8,

    /// Indicates whether DataSync is still working on your report, created a
    /// report, or
    /// can't create a complete report.
    status: ?PhaseStatus,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_detail = "ErrorDetail",
        .status = "Status",
    };
};

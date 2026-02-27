const ExperimentReportError = @import("experiment_report_error.zig").ExperimentReportError;
const ExperimentReportStatus = @import("experiment_report_status.zig").ExperimentReportStatus;

/// Describes the state of the experiment report generation.
pub const ExperimentReportState = struct {
    /// The error information of the experiment when the experiment report
    /// generation has failed.
    @"error": ?ExperimentReportError,

    /// The reason for the state of the experiment report generation.
    reason: ?[]const u8,

    /// The state of the experiment report generation.
    status: ?ExperimentReportStatus,

    pub const json_field_names = .{
        .@"error" = "error",
        .reason = "reason",
        .status = "status",
    };
};

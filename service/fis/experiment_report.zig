const ExperimentReportS3Report = @import("experiment_report_s3_report.zig").ExperimentReportS3Report;
const ExperimentReportState = @import("experiment_report_state.zig").ExperimentReportState;

/// Describes the experiment report.
pub const ExperimentReport = struct {
    /// The S3 destination of the experiment report.
    s_3_reports: ?[]const ExperimentReportS3Report = null,

    /// The state of the experiment report.
    state: ?ExperimentReportState = null,

    pub const json_field_names = .{
        .s_3_reports = "s3Reports",
        .state = "state",
    };
};

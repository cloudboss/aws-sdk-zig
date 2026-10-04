const JobReport = @import("job_report.zig").JobReport;
const ReportStatus = @import("report_status.zig").ReportStatus;

/// Contains insights for a run, including report status, and job-level
/// aggregated metrics such as per job execution time and median job execution
/// time.
pub const RunInsights = struct {
    /// The job-level aggregated report for the run.
    job_report: ?JobReport = null,

    /// The status of the insights report for the run.
    status: ?ReportStatus = null,

    pub const json_field_names = .{
        .job_report = "jobReport",
        .status = "status",
    };
};

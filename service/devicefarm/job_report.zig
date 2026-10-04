const JobReportMetrics = @import("job_report_metrics.zig").JobReportMetrics;

/// Contains aggregated job-level metrics for a run.
pub const JobReport = struct {
    /// A URL to the detailed job results.
    job_details_url: ?[]const u8 = null,

    /// A message associated with the job report.
    message: ?[]const u8 = null,

    /// The aggregated job-level metrics for the run.
    metrics: ?JobReportMetrics = null,

    pub const json_field_names = .{
        .job_details_url = "jobDetailsUrl",
        .message = "message",
        .metrics = "metrics",
    };
};

const TestReportMetrics = @import("test_report_metrics.zig").TestReportMetrics;

/// Contains aggregated test-level metrics for a job.
pub const TestReport = struct {
    /// A message associated with the test report.
    message: ?[]const u8 = null,

    /// The aggregated test-level metrics for the job.
    metrics: ?TestReportMetrics = null,

    /// A URL to the detailed test results.
    test_details_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
        .metrics = "metrics",
        .test_details_url = "testDetailsUrl",
    };
};

const ReportStatus = @import("report_status.zig").ReportStatus;
const TestReport = @import("test_report.zig").TestReport;

/// Contains insights for a job, including report status, and test-level
/// aggregated metrics such as per test execution time and median test execution
/// time.
pub const JobInsights = struct {
    /// The status of the insights report for the job.
    status: ?ReportStatus = null,

    /// The test-level aggregated report for the job.
    test_report: ?TestReport = null,

    pub const json_field_names = .{
        .status = "status",
        .test_report = "testReport",
    };
};

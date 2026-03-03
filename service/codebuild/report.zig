const CodeCoverageReportSummary = @import("code_coverage_report_summary.zig").CodeCoverageReportSummary;
const ReportExportConfig = @import("report_export_config.zig").ReportExportConfig;
const ReportStatusType = @import("report_status_type.zig").ReportStatusType;
const TestReportSummary = @import("test_report_summary.zig").TestReportSummary;
const ReportType = @import("report_type.zig").ReportType;

/// Information about the results from running a series of test cases during the
/// run of a
/// build project. The test cases are specified in the buildspec for the build
/// project using
/// one or more paths to the test case files. You can specify any type of tests
/// you want,
/// such as unit tests, integration tests, and functional tests.
pub const Report = struct {
    /// The ARN of the report run.
    arn: ?[]const u8 = null,

    /// A `CodeCoverageReportSummary` object that contains a code coverage summary
    /// for
    /// this report.
    code_coverage_summary: ?CodeCoverageReportSummary = null,

    /// The date and time this report run occurred.
    created: ?i64 = null,

    /// The ARN of the build run that generated this report.
    execution_id: ?[]const u8 = null,

    /// The date and time a report expires. A report expires 30 days after it is
    /// created. An
    /// expired report is not available to view in CodeBuild.
    expired: ?i64 = null,

    /// Information about where the raw data used to generate this report was
    /// exported.
    export_config: ?ReportExportConfig = null,

    /// The name of the report that was run.
    name: ?[]const u8 = null,

    /// The ARN of the report group associated with this report.
    report_group_arn: ?[]const u8 = null,

    /// The status of this report.
    status: ?ReportStatusType = null,

    /// A `TestReportSummary` object that contains information about this test
    /// report.
    test_summary: ?TestReportSummary = null,

    /// A boolean that specifies if this report run is truncated. The list of test
    /// cases is
    /// truncated after the maximum number of test cases is reached.
    truncated: ?bool = null,

    /// The type of the report that was run.
    ///
    /// **CODE_COVERAGE**
    ///
    /// A code coverage report.
    ///
    /// **TEST**
    ///
    /// A test report.
    @"type": ?ReportType = null,

    pub const json_field_names = .{
        .arn = "arn",
        .code_coverage_summary = "codeCoverageSummary",
        .created = "created",
        .execution_id = "executionId",
        .expired = "expired",
        .export_config = "exportConfig",
        .name = "name",
        .report_group_arn = "reportGroupArn",
        .status = "status",
        .test_summary = "testSummary",
        .truncated = "truncated",
        .@"type" = "type",
    };
};

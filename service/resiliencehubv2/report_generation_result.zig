const ReportOutput = @import("report_output.zig").ReportOutput;
const ReportType = @import("report_type.zig").ReportType;
const ReportGenerationStatus = @import("report_generation_status.zig").ReportGenerationStatus;

/// Result of a report generation attempt.
pub const ReportGenerationResult = struct {
    /// Present for FAILURE_MODE reports.
    assessment_id: ?[]const u8 = null,

    /// The timestamp when the report was created.
    created_at: ?i64 = null,

    /// Present when status is SUCCEEDED or FAILED.
    report_output: ?ReportOutput = null,

    /// The type of the generated report.
    report_type: ReportType,

    /// The service this report was generated for.
    service_arn: ?[]const u8 = null,

    /// The status of the report generation.
    status: ReportGenerationStatus,

    test_run_id: ?[]const u8 = null,

    test_template_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .assessment_id = "assessmentId",
        .created_at = "createdAt",
        .report_output = "reportOutput",
        .report_type = "reportType",
        .service_arn = "serviceArn",
        .status = "status",
        .test_run_id = "testRunId",
        .test_template_arn = "testTemplateArn",
    };
};

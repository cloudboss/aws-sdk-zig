const ReportOutput = @import("report_output.zig").ReportOutput;

/// Information about a generated execution report.
pub const GeneratedReport = struct {
    /// The timestamp when the report was generated.
    report_generation_time: ?i64 = null,

    /// The output location or cause of a failure in report generation.
    report_output: ?ReportOutput = null,

    pub const json_field_names = .{
        .report_generation_time = "reportGenerationTime",
        .report_output = "reportOutput",
    };
};

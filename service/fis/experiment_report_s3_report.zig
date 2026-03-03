/// Describes the S3 destination for the report.
pub const ExperimentReportS3Report = struct {
    /// The Amazon Resource Name (ARN) of the generated report.
    arn: ?[]const u8 = null,

    /// The report type for the experiment report.
    report_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .report_type = "reportType",
    };
};

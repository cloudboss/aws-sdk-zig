/// Contains the unmodified data for the report. For more information, see .
pub const ReportWithRawData = struct {
    /// The value of the requested data field from the report.
    data: ?[]const u8 = null,

    /// The ARN of the report.
    report_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .data = "data",
        .report_arn = "reportArn",
    };
};

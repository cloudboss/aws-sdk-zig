const AnalyzerNameUnion = @import("analyzer_name_union.zig").AnalyzerNameUnion;
const S3Object = @import("s3_object.zig").S3Object;
const AntipatternReportStatus = @import("antipattern_report_status.zig").AntipatternReportStatus;

/// The anti-pattern report result.
pub const AntipatternReportResult = struct {
    /// The analyzer name.
    analyzer_name: ?AnalyzerNameUnion = null,

    anti_pattern_report_s3_object: ?S3Object = null,

    /// The status of the anti-pattern report generation.
    antipattern_report_status: ?AntipatternReportStatus = null,

    /// The status message for the anti-pattern.
    antipattern_report_status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .analyzer_name = "analyzerName",
        .anti_pattern_report_s3_object = "antiPatternReportS3Object",
        .antipattern_report_status = "antipatternReportStatus",
        .antipattern_report_status_message = "antipatternReportStatusMessage",
    };
};

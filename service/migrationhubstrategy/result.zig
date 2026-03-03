const AnalysisStatusUnion = @import("analysis_status_union.zig").AnalysisStatusUnion;
const AnalysisType = @import("analysis_type.zig").AnalysisType;
const AntipatternReportResult = @import("antipattern_report_result.zig").AntipatternReportResult;

/// The error in server analysis.
pub const Result = struct {
    /// The error in server analysis.
    analysis_status: ?AnalysisStatusUnion = null,

    /// The error in server analysis.
    analysis_type: ?AnalysisType = null,

    /// The error in server analysis.
    antipattern_report_result_list: ?[]const AntipatternReportResult = null,

    /// The error in server analysis.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .analysis_status = "analysisStatus",
        .analysis_type = "analysisType",
        .antipattern_report_result_list = "antipatternReportResultList",
        .status_message = "statusMessage",
    };
};

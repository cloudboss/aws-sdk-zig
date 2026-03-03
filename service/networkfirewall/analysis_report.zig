const EnabledAnalysisType = @import("enabled_analysis_type.zig").EnabledAnalysisType;

/// A report that captures key activity from the last 30 days of network traffic
/// monitored by your firewall.
///
/// You can generate up to one report per traffic type, per 30 day period. For
/// example, when you successfully create an HTTP traffic report,
/// you cannot create another HTTP traffic report until 30 days pass.
/// Alternatively, if you generate a report that combines metrics on both HTTP
/// and HTTPS traffic, you cannot create another report for either traffic type
/// until 30 days pass.
pub const AnalysisReport = struct {
    /// The unique ID of the query that ran when you requested an analysis report.
    analysis_report_id: ?[]const u8 = null,

    /// The type of traffic that will be used to generate a report.
    analysis_type: ?EnabledAnalysisType = null,

    /// The date and time the analysis report was ran.
    report_time: ?i64 = null,

    /// The status of the analysis report you specify. Statuses include `RUNNING`,
    /// `COMPLETED`, or `FAILED`.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .analysis_report_id = "AnalysisReportId",
        .analysis_type = "AnalysisType",
        .report_time = "ReportTime",
        .status = "Status",
    };
};

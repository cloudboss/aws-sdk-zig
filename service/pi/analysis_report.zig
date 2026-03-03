const Insight = @import("insight.zig").Insight;
const ServiceType = @import("service_type.zig").ServiceType;
const AnalysisStatus = @import("analysis_status.zig").AnalysisStatus;

/// Retrieves the summary of the performance analysis report created for a time
/// period.
pub const AnalysisReport = struct {
    /// The name of the analysis report.
    analysis_report_id: []const u8,

    /// The time you created the analysis report.
    create_time: ?i64 = null,

    /// The analysis end time in the report.
    end_time: ?i64 = null,

    /// The unique identifier of the analysis report.
    identifier: ?[]const u8 = null,

    /// The list of identified insights in the analysis report.
    insights: ?[]const Insight = null,

    /// List the tags for the Amazon Web Services service for which Performance
    /// Insights returns metrics. Valid values are as follows:
    ///
    /// * `RDS`
    ///
    /// * `DOCDB`
    service_type: ?ServiceType = null,

    /// The analysis start time in the report.
    start_time: ?i64 = null,

    /// The status of the created analysis report.
    status: ?AnalysisStatus = null,

    pub const json_field_names = .{
        .analysis_report_id = "AnalysisReportId",
        .create_time = "CreateTime",
        .end_time = "EndTime",
        .identifier = "Identifier",
        .insights = "Insights",
        .service_type = "ServiceType",
        .start_time = "StartTime",
        .status = "Status",
    };
};

const AnalysisStatus = @import("analysis_status.zig").AnalysisStatus;
const Tag = @import("tag.zig").Tag;

/// Retrieves the details of the performance analysis report.
pub const AnalysisReportSummary = struct {
    /// The name of the analysis report.
    analysis_report_id: ?[]const u8,

    /// The time you created the analysis report.
    create_time: ?i64,

    /// The end time of the analysis in the report.
    end_time: ?i64,

    /// The start time of the analysis in the report.
    start_time: ?i64,

    /// The status of the analysis report.
    status: ?AnalysisStatus,

    /// List of all the tags added to the analysis report.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .analysis_report_id = "AnalysisReportId",
        .create_time = "CreateTime",
        .end_time = "EndTime",
        .start_time = "StartTime",
        .status = "Status",
        .tags = "Tags",
    };
};

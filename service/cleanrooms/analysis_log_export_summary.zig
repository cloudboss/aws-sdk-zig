const LogExportAnalysisType = @import("log_export_analysis_type.zig").LogExportAnalysisType;
const AnalysisLogExportStatus = @import("analysis_log_export_status.zig").AnalysisLogExportStatus;

/// A summary of an analysis log export, including its identifier, status,
/// analysis type, and creation time. Returned by `ListAnalysisLogExports`.
pub const AnalysisLogExportSummary = struct {
    /// The unique identifier of the protected query that the analysis logs were
    /// exported for.
    analysis_id: []const u8,

    /// The unique identifier of the analysis log export.
    analysis_log_export_id: []const u8,

    /// The type of analysis that the logs were exported for. Currently, only
    /// `PROTECTED_QUERY` is supported.
    analysis_type: LogExportAnalysisType,

    /// The time the analysis log export was created.
    create_time: i64,

    /// The status of the analysis log export. Possible values are:
    ///
    /// * `IN_PROGRESS` – The export is currently running.
    /// * `SUCCESS` – The export completed successfully.
    /// * `FAILED` – The export failed.
    status: AnalysisLogExportStatus,

    pub const json_field_names = .{
        .analysis_id = "analysisId",
        .analysis_log_export_id = "analysisLogExportId",
        .analysis_type = "analysisType",
        .create_time = "createTime",
        .status = "status",
    };
};

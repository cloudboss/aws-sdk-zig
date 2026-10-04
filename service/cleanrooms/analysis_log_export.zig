const LogExportAnalysisType = @import("log_export_analysis_type.zig").LogExportAnalysisType;
const AnalysisLogExportError = @import("analysis_log_export_error.zig").AnalysisLogExportError;
const AnalysisLogExportResultConfiguration = @import("analysis_log_export_result_configuration.zig").AnalysisLogExportResultConfiguration;
const AnalysisLogExportStatus = @import("analysis_log_export_status.zig").AnalysisLogExportStatus;

/// An export of the redacted Apache Spark logs for a protected query.
pub const AnalysisLogExport = struct {
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

    /// The analysis log export error. This is present only when the export `status`
    /// is `FAILED`.
    @"error": ?AnalysisLogExportError = null,

    /// The unique identifier of the membership that the analysis log export belongs
    /// to.
    membership_id: []const u8,

    /// Contains the details needed to write the exported analysis logs.
    result_configuration: AnalysisLogExportResultConfiguration,

    /// The status of the analysis log export. Possible values are:
    ///
    /// * `IN_PROGRESS` – The export is currently running.
    /// * `SUCCESS` – The export completed successfully.
    /// * `FAILED` – The export failed. See the `error` field for details.
    status: AnalysisLogExportStatus,

    /// The time the analysis log export was last updated.
    update_time: i64,

    pub const json_field_names = .{
        .analysis_id = "analysisId",
        .analysis_log_export_id = "analysisLogExportId",
        .analysis_type = "analysisType",
        .create_time = "createTime",
        .@"error" = "error",
        .membership_id = "membershipId",
        .result_configuration = "resultConfiguration",
        .status = "status",
        .update_time = "updateTime",
    };
};

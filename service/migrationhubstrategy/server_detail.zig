const S3Object = @import("s3_object.zig").S3Object;
const AntipatternReportStatus = @import("antipattern_report_status.zig").AntipatternReportStatus;
const StrategySummary = @import("strategy_summary.zig").StrategySummary;
const RunTimeAssessmentStatus = @import("run_time_assessment_status.zig").RunTimeAssessmentStatus;
const AntipatternSeveritySummary = @import("antipattern_severity_summary.zig").AntipatternSeveritySummary;
const RecommendationSet = @import("recommendation_set.zig").RecommendationSet;
const ServerError = @import("server_error.zig").ServerError;
const SystemInfo = @import("system_info.zig").SystemInfo;

/// Detailed information about a server.
pub const ServerDetail = struct {
    /// The S3 bucket name and Amazon S3 key name for anti-pattern report.
    antipattern_report_s3_object: ?S3Object = null,

    /// The status of the anti-pattern report generation.
    antipattern_report_status: ?AntipatternReportStatus = null,

    /// A message about the status of the anti-pattern report generation.
    antipattern_report_status_message: ?[]const u8 = null,

    /// A list of strategy summaries.
    application_component_strategy_summary: ?[]const StrategySummary = null,

    /// The status of assessment for the server.
    data_collection_status: ?RunTimeAssessmentStatus = null,

    /// The server ID.
    id: ?[]const u8 = null,

    /// The timestamp of when the server was assessed.
    last_analyzed_timestamp: ?i64 = null,

    /// A list of anti-pattern severity summaries.
    list_antipattern_severity_summary: ?[]const AntipatternSeveritySummary = null,

    /// The name of the server.
    name: ?[]const u8 = null,

    /// A set of recommendations.
    recommendation_set: ?RecommendationSet = null,

    /// The error in server analysis.
    server_error: ?ServerError = null,

    /// The type of server.
    server_type: ?[]const u8 = null,

    /// A message about the status of data collection, which contains detailed
    /// descriptions of
    /// any error messages.
    status_message: ?[]const u8 = null,

    /// System information about the server.
    system_info: ?SystemInfo = null,

    pub const json_field_names = .{
        .antipattern_report_s3_object = "antipatternReportS3Object",
        .antipattern_report_status = "antipatternReportStatus",
        .antipattern_report_status_message = "antipatternReportStatusMessage",
        .application_component_strategy_summary = "applicationComponentStrategySummary",
        .data_collection_status = "dataCollectionStatus",
        .id = "id",
        .last_analyzed_timestamp = "lastAnalyzedTimestamp",
        .list_antipattern_severity_summary = "listAntipatternSeveritySummary",
        .name = "name",
        .recommendation_set = "recommendationSet",
        .server_error = "serverError",
        .server_type = "serverType",
        .status_message = "statusMessage",
        .system_info = "systemInfo",
    };
};

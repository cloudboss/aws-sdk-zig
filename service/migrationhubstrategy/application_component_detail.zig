const SrcCodeOrDbAnalysisStatus = @import("src_code_or_db_analysis_status.zig").SrcCodeOrDbAnalysisStatus;
const S3Object = @import("s3_object.zig").S3Object;
const AntipatternReportStatus = @import("antipattern_report_status.zig").AntipatternReportStatus;
const AppType = @import("app_type.zig").AppType;
const AppUnitError = @import("app_unit_error.zig").AppUnitError;
const DatabaseConfigDetail = @import("database_config_detail.zig").DatabaseConfigDetail;
const InclusionStatus = @import("inclusion_status.zig").InclusionStatus;
const AntipatternSeveritySummary = @import("antipattern_severity_summary.zig").AntipatternSeveritySummary;
const RecommendationSet = @import("recommendation_set.zig").RecommendationSet;
const ResourceSubType = @import("resource_sub_type.zig").ResourceSubType;
const Result = @import("result.zig").Result;
const RuntimeAnalysisStatus = @import("runtime_analysis_status.zig").RuntimeAnalysisStatus;
const SourceCodeRepository = @import("source_code_repository.zig").SourceCodeRepository;

/// Contains detailed information about an application component.
pub const ApplicationComponentDetail = struct {
    /// The status of analysis, if the application component has source code or an
    /// associated
    /// database.
    analysis_status: ?SrcCodeOrDbAnalysisStatus,

    /// The S3 bucket name and the Amazon S3 key name for the anti-pattern report.
    antipattern_report_s3_object: ?S3Object,

    /// The status of the anti-pattern report generation.
    antipattern_report_status: ?AntipatternReportStatus,

    /// The status message for the anti-pattern.
    antipattern_report_status_message: ?[]const u8,

    /// The type of application component.
    app_type: ?AppType,

    /// The error in the analysis of the source code or database.
    app_unit_error: ?AppUnitError,

    /// The ID of the server that the application component is running on.
    associated_server_id: ?[]const u8,

    /// Configuration details for the database associated with the application
    /// component.
    database_config_detail: ?DatabaseConfigDetail,

    /// The ID of the application component.
    id: ?[]const u8,

    /// Indicates whether the application component has been included for server
    /// recommendation
    /// or not.
    inclusion_status: ?InclusionStatus,

    /// The timestamp of when the application component was assessed.
    last_analyzed_timestamp: ?i64,

    /// A list of anti-pattern severity summaries.
    list_antipattern_severity_summary: ?[]const AntipatternSeveritySummary,

    /// Set to true if the application component is running on multiple servers.
    more_server_association_exists: ?bool,

    /// The name of application component.
    name: ?[]const u8,

    /// OS driver.
    os_driver: ?[]const u8,

    /// OS version.
    os_version: ?[]const u8,

    /// The top recommendation set for the application component.
    recommendation_set: ?RecommendationSet,

    /// The application component subtype.
    resource_sub_type: ?ResourceSubType,

    /// A list of the analysis results.
    result_list: ?[]const Result,

    /// The status of the application unit.
    runtime_status: ?RuntimeAnalysisStatus,

    /// The status message for the application unit.
    runtime_status_message: ?[]const u8,

    /// Details about the source code repository associated with the application
    /// component.
    source_code_repositories: ?[]const SourceCodeRepository,

    /// A detailed description of the analysis status and any failure message.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .analysis_status = "analysisStatus",
        .antipattern_report_s3_object = "antipatternReportS3Object",
        .antipattern_report_status = "antipatternReportStatus",
        .antipattern_report_status_message = "antipatternReportStatusMessage",
        .app_type = "appType",
        .app_unit_error = "appUnitError",
        .associated_server_id = "associatedServerId",
        .database_config_detail = "databaseConfigDetail",
        .id = "id",
        .inclusion_status = "inclusionStatus",
        .last_analyzed_timestamp = "lastAnalyzedTimestamp",
        .list_antipattern_severity_summary = "listAntipatternSeveritySummary",
        .more_server_association_exists = "moreServerAssociationExists",
        .name = "name",
        .os_driver = "osDriver",
        .os_version = "osVersion",
        .recommendation_set = "recommendationSet",
        .resource_sub_type = "resourceSubType",
        .result_list = "resultList",
        .runtime_status = "runtimeStatus",
        .runtime_status_message = "runtimeStatusMessage",
        .source_code_repositories = "sourceCodeRepositories",
        .status_message = "statusMessage",
    };
};

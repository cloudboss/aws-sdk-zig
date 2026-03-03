const S3Object = @import("s3_object.zig").S3Object;
const AntipatternReportStatus = @import("antipattern_report_status.zig").AntipatternReportStatus;
const AntipatternSeveritySummary = @import("antipattern_severity_summary.zig").AntipatternSeveritySummary;
const ApplicationComponentStatusSummary = @import("application_component_status_summary.zig").ApplicationComponentStatusSummary;
const StrategySummary = @import("strategy_summary.zig").StrategySummary;
const ApplicationComponentSummary = @import("application_component_summary.zig").ApplicationComponentSummary;
const ServerStatusSummary = @import("server_status_summary.zig").ServerStatusSummary;
const ServerSummary = @import("server_summary.zig").ServerSummary;

/// Contains the summary of the assessment results.
pub const AssessmentSummary = struct {
    /// The Amazon S3 object containing the anti-pattern report.
    antipattern_report_s3_object: ?S3Object = null,

    /// The status of the anti-pattern report.
    antipattern_report_status: ?AntipatternReportStatus = null,

    /// The status message of the anti-pattern report.
    antipattern_report_status_message: ?[]const u8 = null,

    /// The time the assessment was performed.
    last_analyzed_timestamp: ?i64 = null,

    /// List of AntipatternSeveritySummary.
    list_antipattern_severity_summary: ?[]const AntipatternSeveritySummary = null,

    /// List of status summaries of the analyzed application components.
    list_application_component_status_summary: ?[]const ApplicationComponentStatusSummary = null,

    /// List of ApplicationComponentStrategySummary.
    list_application_component_strategy_summary: ?[]const StrategySummary = null,

    /// List of ApplicationComponentSummary.
    list_application_component_summary: ?[]const ApplicationComponentSummary = null,

    /// List of status summaries of the analyzed servers.
    list_server_status_summary: ?[]const ServerStatusSummary = null,

    /// List of ServerStrategySummary.
    list_server_strategy_summary: ?[]const StrategySummary = null,

    /// List of ServerSummary.
    list_server_summary: ?[]const ServerSummary = null,

    pub const json_field_names = .{
        .antipattern_report_s3_object = "antipatternReportS3Object",
        .antipattern_report_status = "antipatternReportStatus",
        .antipattern_report_status_message = "antipatternReportStatusMessage",
        .last_analyzed_timestamp = "lastAnalyzedTimestamp",
        .list_antipattern_severity_summary = "listAntipatternSeveritySummary",
        .list_application_component_status_summary = "listApplicationComponentStatusSummary",
        .list_application_component_strategy_summary = "listApplicationComponentStrategySummary",
        .list_application_component_summary = "listApplicationComponentSummary",
        .list_server_status_summary = "listServerStatusSummary",
        .list_server_strategy_summary = "listServerStrategySummary",
        .list_server_summary = "listServerSummary",
    };
};

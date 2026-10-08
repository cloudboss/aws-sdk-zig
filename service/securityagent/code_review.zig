const Assets = @import("assets.zig").Assets;
const CodeRemediationStrategy = @import("code_remediation_strategy.zig").CodeRemediationStrategy;
const CloudWatchLog = @import("cloud_watch_log.zig").CloudWatchLog;
const ReportDestination = @import("report_destination.zig").ReportDestination;
const ReportFilters = @import("report_filters.zig").ReportFilters;
const ValidationMode = @import("validation_mode.zig").ValidationMode;

/// Represents a code review configuration that defines the parameters for
/// automated security-focused code analysis, including target assets and
/// logging configuration.
pub const CodeReview = struct {
    /// The unique identifier of the agent space that contains the code review.
    agent_space_id: []const u8,

    /// The assets included in the code review.
    assets: Assets,

    /// The code remediation strategy for the code review.
    code_remediation_strategy: ?CodeRemediationStrategy = null,

    /// The unique identifier of the code review.
    code_review_id: []const u8,

    /// The date and time the code review was created, in UTC format.
    created_at: ?i64 = null,

    /// The CloudWatch Logs configuration for the code review.
    log_config: ?CloudWatchLog = null,

    /// The maximum number of billable task hours allowed for jobs started from this
    /// code review. If a job reaches the configured limit, it is gracefully
    /// stopped. If not set, jobs run to completion with no budget cap.
    max_task_hours: ?f64 = null,

    /// The destination for publishing scan reports to an integrated document
    /// provider.
    report_destination: ?ReportDestination = null,

    /// The report-generation filters applied when the report is exported.
    report_filters: ?ReportFilters = null,

    /// The IAM service role used for the code review.
    service_role: ?[]const u8 = null,

    /// The title of the code review.
    title: []const u8,

    /// The date and time the code review was last updated, in UTC format.
    updated_at: ?i64 = null,

    /// The validation mode for the code review. Valid values are SIMULATED and
    /// DISABLED.
    validation_mode: ?ValidationMode = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .assets = "assets",
        .code_remediation_strategy = "codeRemediationStrategy",
        .code_review_id = "codeReviewId",
        .created_at = "createdAt",
        .log_config = "logConfig",
        .max_task_hours = "maxTaskHours",
        .report_destination = "reportDestination",
        .report_filters = "reportFilters",
        .service_role = "serviceRole",
        .title = "title",
        .updated_at = "updatedAt",
        .validation_mode = "validationMode",
    };
};

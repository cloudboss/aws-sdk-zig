const CodeRemediationStrategy = @import("code_remediation_strategy.zig").CodeRemediationStrategy;
const DocumentInfo = @import("document_info.zig").DocumentInfo;
const ErrorInformation = @import("error_information.zig").ErrorInformation;
const ExecutionContext = @import("execution_context.zig").ExecutionContext;
const IntegratedRepository = @import("integrated_repository.zig").IntegratedRepository;
const CloudWatchLog = @import("cloud_watch_log.zig").CloudWatchLog;
const ReportDestination = @import("report_destination.zig").ReportDestination;
const SourceCodeRepository = @import("source_code_repository.zig").SourceCodeRepository;
const JobStatus = @import("job_status.zig").JobStatus;
const Step = @import("step.zig").Step;

/// Represents a code review job, which is an execution instance of a code
/// review. A code review job progresses through preflight, static analysis, and
/// finalizing steps.
pub const CodeReviewJob = struct {
    /// The code remediation strategy for the code review job.
    code_remediation_strategy: ?CodeRemediationStrategy = null,

    /// The unique identifier of the code review associated with the job.
    code_review_id: ?[]const u8 = null,

    /// The unique identifier of the code review job.
    code_review_job_id: ?[]const u8 = null,

    /// The date and time the code review job was created, in UTC format.
    created_at: ?i64 = null,

    /// The list of documents providing context for the code review job.
    documents: ?[]const DocumentInfo = null,

    /// Error information if the code review job encountered an error.
    error_information: ?ErrorInformation = null,

    /// The execution context messages for the code review job.
    execution_context: ?[]const ExecutionContext = null,

    /// The list of integrated repositories associated with the code review job.
    integrated_repositories: ?[]const IntegratedRepository = null,

    /// The CloudWatch Logs configuration for the code review job.
    log_config: ?CloudWatchLog = null,

    /// The maximum number of billable task hours allowed for this code review job.
    /// If the cumulative task hours reach this limit, the job is gracefully
    /// stopped.
    max_task_hours: ?f64 = null,

    /// An overview of the code review job results.
    overview: ?[]const u8 = null,

    /// The destination for publishing scan reports to an integrated document
    /// provider.
    report_destination: ?ReportDestination = null,

    /// The IAM service role used for the code review job.
    service_role: ?[]const u8 = null,

    /// The list of source code repositories analyzed during the code review job.
    source_code: ?[]const SourceCodeRepository = null,

    /// The current status of the code review job.
    status: ?JobStatus = null,

    /// The list of steps in the code review job execution.
    steps: ?[]const Step = null,

    /// The title of the code review job.
    title: ?[]const u8 = null,

    /// The date and time the code review job was last updated, in UTC format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .code_remediation_strategy = "codeRemediationStrategy",
        .code_review_id = "codeReviewId",
        .code_review_job_id = "codeReviewJobId",
        .created_at = "createdAt",
        .documents = "documents",
        .error_information = "errorInformation",
        .execution_context = "executionContext",
        .integrated_repositories = "integratedRepositories",
        .log_config = "logConfig",
        .max_task_hours = "maxTaskHours",
        .overview = "overview",
        .report_destination = "reportDestination",
        .service_role = "serviceRole",
        .source_code = "sourceCode",
        .status = "status",
        .steps = "steps",
        .title = "title",
        .updated_at = "updatedAt",
    };
};

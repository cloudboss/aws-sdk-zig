const DocumentInfo = @import("document_info.zig").DocumentInfo;
const ErrorInformation = @import("error_information.zig").ErrorInformation;
const IntegratedRepository = @import("integrated_repository.zig").IntegratedRepository;
const ReportDestination = @import("report_destination.zig").ReportDestination;
const SourceCodeRepository = @import("source_code_repository.zig").SourceCodeRepository;
const JobStatus = @import("job_status.zig").JobStatus;

/// Represents a threat model job, which is an execution instance of a threat
/// model.
pub const ThreatModelJob = struct {
    /// The unique identifier of the agent space.
    agent_space_id: ?[]const u8 = null,

    /// The date and time the threat model job was created, in UTC format.
    created_at: ?i64 = null,

    /// The list of documents used for threat modeling.
    documents: ?[]const DocumentInfo = null,

    /// Error information if the threat model job encountered an error.
    error_information: ?ErrorInformation = null,

    /// The date and time the threat model job execution ended, in UTC format.
    execution_end_time: ?i64 = null,

    /// The date and time the threat model job execution started, in UTC format.
    execution_start_time: ?i64 = null,

    /// The list of integrated repositories used for threat modeling.
    integrated_repositories: ?[]const IntegratedRepository = null,

    /// The destination for publishing scan reports to an integrated document
    /// provider.
    report_destination: ?ReportDestination = null,

    /// The scoped documents for the agent to focus on during threat modeling.
    scope_docs: ?[]const DocumentInfo = null,

    /// The list of source code repositories used for threat modeling.
    source_code: ?[]const SourceCodeRepository = null,

    /// The current status of the threat model job.
    status: ?JobStatus = null,

    /// The system overview generated during threat modeling.
    system_overview: ?[]const u8 = null,

    /// The unique identifier of the threat model associated with the job.
    threat_model_id: ?[]const u8 = null,

    /// The unique identifier of the threat model job.
    threat_model_job_id: ?[]const u8 = null,

    /// The title of the threat model job.
    title: ?[]const u8 = null,

    /// The date and time the threat model job was last updated, in UTC format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .created_at = "createdAt",
        .documents = "documents",
        .error_information = "errorInformation",
        .execution_end_time = "executionEndTime",
        .execution_start_time = "executionStartTime",
        .integrated_repositories = "integratedRepositories",
        .report_destination = "reportDestination",
        .scope_docs = "scopeDocs",
        .source_code = "sourceCode",
        .status = "status",
        .system_overview = "systemOverview",
        .threat_model_id = "threatModelId",
        .threat_model_job_id = "threatModelJobId",
        .title = "title",
        .updated_at = "updatedAt",
    };
};

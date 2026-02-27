const ArrayPropertiesSummary = @import("array_properties_summary.zig").ArrayPropertiesSummary;
const ContainerSummary = @import("container_summary.zig").ContainerSummary;
const NodePropertiesSummary = @import("node_properties_summary.zig").NodePropertiesSummary;
const JobStatus = @import("job_status.zig").JobStatus;

/// An object that represents summary details of a job.
pub const JobSummary = struct {
    /// The array properties of the job, if it's an array job.
    array_properties: ?ArrayPropertiesSummary,

    /// An object that represents the details of the container that's associated
    /// with the
    /// job.
    container: ?ContainerSummary,

    /// The Unix timestamp (in milliseconds) for when the job was created. For
    /// non-array jobs and
    /// parent array jobs, this is when the job entered the `SUBMITTED` state (at
    /// the time
    /// [SubmitJob](https://docs.aws.amazon.com/batch/latest/APIReference/API_SubmitJob.html)
    /// was called). For array child jobs, this is when the child job was spawned by
    /// its parent and
    /// entered the `PENDING` state.
    created_at: ?i64,

    /// The Amazon Resource Name (ARN) of the job.
    job_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the job definition.
    job_definition: ?[]const u8,

    /// The job ID.
    job_id: []const u8,

    /// The job name.
    job_name: []const u8,

    /// The node properties for a single node in a job summary list.
    ///
    /// This isn't applicable to jobs that are running on Fargate resources.
    node_properties: ?NodePropertiesSummary,

    /// The Unix timestamp for when the job was started. More specifically, it's
    /// when the job
    /// transitioned from the `STARTING` state to the `RUNNING` state.
    started_at: ?i64,

    /// The current status for the job.
    status: ?JobStatus,

    /// A short, human-readable string to provide more details for the current
    /// status of the
    /// job.
    status_reason: ?[]const u8,

    /// The Unix timestamp for when the job was stopped. More specifically, it's
    /// when the job
    /// transitioned from the `RUNNING` state to a terminal state, such as
    /// `SUCCEEDED` or `FAILED`.
    stopped_at: ?i64,

    pub const json_field_names = .{
        .array_properties = "arrayProperties",
        .container = "container",
        .created_at = "createdAt",
        .job_arn = "jobArn",
        .job_definition = "jobDefinition",
        .job_id = "jobId",
        .job_name = "jobName",
        .node_properties = "nodeProperties",
        .started_at = "startedAt",
        .status = "status",
        .status_reason = "statusReason",
        .stopped_at = "stoppedAt",
    };
};

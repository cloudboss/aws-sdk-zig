const aws = @import("aws");

const ArrayPropertiesDetail = @import("array_properties_detail.zig").ArrayPropertiesDetail;
const AttemptDetail = @import("attempt_detail.zig").AttemptDetail;
const ConsumableResourceProperties = @import("consumable_resource_properties.zig").ConsumableResourceProperties;
const ContainerDetail = @import("container_detail.zig").ContainerDetail;
const JobDependency = @import("job_dependency.zig").JobDependency;
const EcsPropertiesDetail = @import("ecs_properties_detail.zig").EcsPropertiesDetail;
const EksAttemptDetail = @import("eks_attempt_detail.zig").EksAttemptDetail;
const EksPropertiesDetail = @import("eks_properties_detail.zig").EksPropertiesDetail;
const NodeDetails = @import("node_details.zig").NodeDetails;
const NodeProperties = @import("node_properties.zig").NodeProperties;
const PlatformCapability = @import("platform_capability.zig").PlatformCapability;
const RetryStrategy = @import("retry_strategy.zig").RetryStrategy;
const JobStatus = @import("job_status.zig").JobStatus;
const JobTimeout = @import("job_timeout.zig").JobTimeout;

/// An object that represents an Batch job.
pub const JobDetail = struct {
    /// The array properties of the job, if it's an array job.
    array_properties: ?ArrayPropertiesDetail = null,

    /// A list of job attempts that are associated with this job.
    attempts: ?[]const AttemptDetail = null,

    /// Contains a list of consumable resources required by the job.
    consumable_resource_properties: ?ConsumableResourceProperties = null,

    /// An object that represents the details for the container that's associated
    /// with the job. If
    /// the details are for a multiple-container job, this object will be empty.
    container: ?ContainerDetail = null,

    /// The Unix timestamp (in milliseconds) for when the job was created. For
    /// non-array jobs and
    /// parent array jobs, this is when the job entered the `SUBMITTED` state. This
    /// is
    /// specifically at the time
    /// [SubmitJob](https://docs.aws.amazon.com/batch/latest/APIReference/API_SubmitJob.html) was called. For array child
    /// jobs, this is when the child job was spawned by its parent and entered the
    /// `PENDING`
    /// state.
    created_at: ?i64 = null,

    /// A list of job IDs that this job depends on.
    depends_on: ?[]const JobDependency = null,

    /// An object with properties that are specific to Amazon ECS-based jobs.
    ecs_properties: ?EcsPropertiesDetail = null,

    /// A list of job attempts that are associated with this job.
    eks_attempts: ?[]const EksAttemptDetail = null,

    /// An object with various properties that are specific to Amazon EKS based
    /// jobs.
    eks_properties: ?EksPropertiesDetail = null,

    /// Indicates whether the job is canceled.
    is_cancelled: ?bool = null,

    /// Indicates whether the job is terminated.
    is_terminated: ?bool = null,

    /// The Amazon Resource Name (ARN) of the job.
    job_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the job definition that this job uses.
    job_definition: []const u8,

    /// The job ID.
    job_id: []const u8,

    /// The job name.
    job_name: []const u8,

    /// The Amazon Resource Name (ARN) of the job queue that the job is associated
    /// with.
    job_queue: []const u8,

    /// An object that represents the details of a node that's associated with a
    /// multi-node parallel
    /// job.
    node_details: ?NodeDetails = null,

    /// An object that represents the node properties of a multi-node parallel job.
    ///
    /// This isn't applicable to jobs that are running on Fargate resources.
    node_properties: ?NodeProperties = null,

    /// Additional parameters that are passed to the job that replace parameter
    /// substitution
    /// placeholders or override any corresponding parameter defaults from the job
    /// definition.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// The platform capabilities required by the job definition. If no value is
    /// specified, it
    /// defaults to `EC2`. Jobs run on Fargate resources specify
    /// `FARGATE`.
    platform_capabilities: ?[]const PlatformCapability = null,

    /// Specifies whether to propagate the tags from the job or job definition to
    /// the corresponding
    /// Amazon ECS task. If no value is specified, the tags aren't propagated. Tags
    /// can only be propagated to
    /// the tasks when the tasks are created. For tags with the same name, job tags
    /// are given priority
    /// over job definitions tags. If the total number of combined tags from the job
    /// and job definition
    /// is over 50, the job is moved to the `FAILED` state.
    propagate_tags: ?bool = null,

    /// The retry strategy to use for this job if an attempt fails.
    retry_strategy: ?RetryStrategy = null,

    /// The scheduling policy of the job definition. This only affects jobs in job
    /// queues with a
    /// fair-share policy. Jobs with a higher scheduling priority are scheduled
    /// before jobs with a lower
    /// scheduling priority.
    scheduling_priority: ?i32 = null,

    /// The share identifier for the job.
    share_identifier: ?[]const u8 = null,

    /// The Unix timestamp (in milliseconds) for when the job was started. More
    /// specifically, it's
    /// when the job transitioned from the `STARTING` state to the `RUNNING` state.
    started_at: i64,

    /// The current status for the job.
    ///
    /// If your jobs don't progress to `STARTING`, see [Jobs stuck in RUNNABLE
    /// status](https://docs.aws.amazon.com/batch/latest/userguide/troubleshooting.html#job_stuck_in_runnable) in the troubleshooting section of the
    /// *Batch User Guide*.
    status: JobStatus,

    /// A short, human-readable string to provide more details for the current
    /// status of the
    /// job.
    ///
    /// * `CAPACITY:INSUFFICIENT_INSTANCE_CAPACITY` - All compute environments have
    /// insufficient capacity to service the job.
    ///
    /// * `MISCONFIGURATION:COMPUTE_ENVIRONMENT_MAX_RESOURCE` - All compute
    ///   environments
    /// have a `maxVcpu` setting that is smaller than the job requirements.
    ///
    /// * `MISCONFIGURATION:JOB_RESOURCE_REQUIREMENT` - All compute environments
    ///   have no
    /// connected instances that meet the job requirements.
    ///
    /// * `MISCONFIGURATION:SERVICE_ROLE_PERMISSIONS` - All compute environments
    ///   have
    /// problems with the service role permissions.
    status_reason: ?[]const u8 = null,

    /// The Unix timestamp (in milliseconds) for when the job was stopped. More
    /// specifically, it's
    /// when the job transitioned from the `RUNNING` state to a terminal state, such
    /// as
    /// `SUCCEEDED` or `FAILED`.
    stopped_at: ?i64 = null,

    /// The tags that are applied to the job.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timeout configuration for the job.
    timeout: ?JobTimeout = null,

    pub const json_field_names = .{
        .array_properties = "arrayProperties",
        .attempts = "attempts",
        .consumable_resource_properties = "consumableResourceProperties",
        .container = "container",
        .created_at = "createdAt",
        .depends_on = "dependsOn",
        .ecs_properties = "ecsProperties",
        .eks_attempts = "eksAttempts",
        .eks_properties = "eksProperties",
        .is_cancelled = "isCancelled",
        .is_terminated = "isTerminated",
        .job_arn = "jobArn",
        .job_definition = "jobDefinition",
        .job_id = "jobId",
        .job_name = "jobName",
        .job_queue = "jobQueue",
        .node_details = "nodeDetails",
        .node_properties = "nodeProperties",
        .parameters = "parameters",
        .platform_capabilities = "platformCapabilities",
        .propagate_tags = "propagateTags",
        .retry_strategy = "retryStrategy",
        .scheduling_priority = "schedulingPriority",
        .share_identifier = "shareIdentifier",
        .started_at = "startedAt",
        .status = "status",
        .status_reason = "statusReason",
        .stopped_at = "stoppedAt",
        .tags = "tags",
        .timeout = "timeout",
    };
};

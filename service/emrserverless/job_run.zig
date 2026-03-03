const aws = @import("aws");

const ResourceUtilization = @import("resource_utilization.zig").ResourceUtilization;
const ConfigurationOverrides = @import("configuration_overrides.zig").ConfigurationOverrides;
const JobRunExecutionIamPolicy = @import("job_run_execution_iam_policy.zig").JobRunExecutionIamPolicy;
const JobDriver = @import("job_driver.zig").JobDriver;
const JobRunMode = @import("job_run_mode.zig").JobRunMode;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const RetryPolicy = @import("retry_policy.zig").RetryPolicy;
const JobRunState = @import("job_run_state.zig").JobRunState;
const TotalResourceUtilization = @import("total_resource_utilization.zig").TotalResourceUtilization;

/// Information about a job run. A job run is a unit of work, such as a Spark
/// JAR, Hive query, or SparkSQL query, that you submit to an Amazon EMR
/// Serverless application.
pub const JobRun = struct {
    /// The ID of the application the job is running on.
    application_id: []const u8,

    /// The execution role ARN of the job run.
    arn: []const u8,

    /// The attempt of the job run.
    attempt: ?i32 = null,

    /// The date and time of when the job run attempt was created.
    attempt_created_at: ?i64 = null,

    /// The date and time of when the job run attempt was last updated.
    attempt_updated_at: ?i64 = null,

    /// The aggregate vCPU, memory, and storage that Amazon Web Services has billed
    /// for the job run. The billed resources include a 1-minute minimum usage for
    /// workers, plus additional storage over 20 GB per worker. Note that billed
    /// resources do not include usage for idle pre-initialized workers.
    billed_resource_utilization: ?ResourceUtilization = null,

    /// The configuration settings that are used to override default configuration.
    configuration_overrides: ?ConfigurationOverrides = null,

    /// The date and time when the job run was created.
    created_at: i64,

    /// The user who created the job run.
    created_by: []const u8,

    /// The date and time when the job was terminated.
    ended_at: ?i64 = null,

    execution_iam_policy: ?JobRunExecutionIamPolicy = null,

    /// The execution role ARN of the job run.
    execution_role: []const u8,

    /// Returns the job run timeout value from the `StartJobRun` call. If no timeout
    /// was specified, then it returns the default timeout of 720 minutes.
    execution_timeout_minutes: ?i64 = null,

    /// The job driver for the job run.
    job_driver: JobDriver,

    /// The ID of the job run.
    job_run_id: []const u8,

    /// The mode of the job run.
    mode: ?JobRunMode = null,

    /// The optional job run name. This doesn't have to be unique.
    name: ?[]const u8 = null,

    network_configuration: ?NetworkConfiguration = null,

    /// The total time for a job in the QUEUED state in milliseconds.
    queued_duration_milliseconds: ?i64 = null,

    /// The Amazon EMR release associated with the application your job is running
    /// on.
    release_label: []const u8,

    /// The retry policy of the job run.
    retry_policy: ?RetryPolicy = null,

    /// The date and time when the job moved to the RUNNING state.
    started_at: ?i64 = null,

    /// The state of the job run.
    state: JobRunState,

    /// The state details of the job run.
    state_details: []const u8,

    /// The tags assigned to the job run.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The job run total execution duration in seconds. This field is only
    /// available for job runs in a `COMPLETED`, `FAILED`, or `CANCELLED` state.
    total_execution_duration_seconds: ?i32 = null,

    /// The aggregate vCPU, memory, and storage resources used from the time the job
    /// starts to execute, until the time the job terminates, rounded up to the
    /// nearest second.
    total_resource_utilization: ?TotalResourceUtilization = null,

    /// The date and time when the job run was updated.
    updated_at: i64,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .arn = "arn",
        .attempt = "attempt",
        .attempt_created_at = "attemptCreatedAt",
        .attempt_updated_at = "attemptUpdatedAt",
        .billed_resource_utilization = "billedResourceUtilization",
        .configuration_overrides = "configurationOverrides",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .ended_at = "endedAt",
        .execution_iam_policy = "executionIamPolicy",
        .execution_role = "executionRole",
        .execution_timeout_minutes = "executionTimeoutMinutes",
        .job_driver = "jobDriver",
        .job_run_id = "jobRunId",
        .mode = "mode",
        .name = "name",
        .network_configuration = "networkConfiguration",
        .queued_duration_milliseconds = "queuedDurationMilliseconds",
        .release_label = "releaseLabel",
        .retry_policy = "retryPolicy",
        .started_at = "startedAt",
        .state = "state",
        .state_details = "stateDetails",
        .tags = "tags",
        .total_execution_duration_seconds = "totalExecutionDurationSeconds",
        .total_resource_utilization = "totalResourceUtilization",
        .updated_at = "updatedAt",
    };
};

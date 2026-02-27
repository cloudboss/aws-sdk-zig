const aws = @import("aws");

const ConfigurationOverrides = @import("configuration_overrides.zig").ConfigurationOverrides;
const FailureReason = @import("failure_reason.zig").FailureReason;
const JobDriver = @import("job_driver.zig").JobDriver;
const RetryPolicyConfiguration = @import("retry_policy_configuration.zig").RetryPolicyConfiguration;
const RetryPolicyExecution = @import("retry_policy_execution.zig").RetryPolicyExecution;
const JobRunState = @import("job_run_state.zig").JobRunState;

/// This entity describes a job run. A job run is a unit of work, such as a
/// Spark jar,
/// PySpark script, or SparkSQL query, that you submit to Amazon EMR on EKS.
pub const JobRun = struct {
    /// The ARN of job run.
    arn: ?[]const u8,

    /// The client token used to start a job run.
    client_token: ?[]const u8,

    /// The configuration settings that are used to override default configuration.
    configuration_overrides: ?ConfigurationOverrides,

    /// The date and time when the job run was created.
    created_at: ?i64,

    /// The user who created the job run.
    created_by: ?[]const u8,

    /// The execution role ARN of the job run.
    execution_role_arn: ?[]const u8,

    /// The reasons why the job run has failed.
    failure_reason: ?FailureReason,

    /// The date and time when the job run has finished.
    finished_at: ?i64,

    /// The ID of the job run.
    id: ?[]const u8,

    /// Parameters of job driver for the job run.
    job_driver: ?JobDriver,

    /// The name of the job run.
    name: ?[]const u8,

    /// The release version of Amazon EMR.
    release_label: ?[]const u8,

    /// The configuration of the retry policy that the job runs on.
    retry_policy_configuration: ?RetryPolicyConfiguration,

    /// The current status of the retry policy executed on the job.
    retry_policy_execution: ?RetryPolicyExecution,

    /// The state of the job run.
    state: ?JobRunState,

    /// Additional details of the job run state.
    state_details: ?[]const u8,

    /// The assigned tags of the job run.
    tags: ?[]const aws.map.StringMapEntry,

    /// The ID of the job run's virtual cluster.
    virtual_cluster_id: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .client_token = "clientToken",
        .configuration_overrides = "configurationOverrides",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .execution_role_arn = "executionRoleArn",
        .failure_reason = "failureReason",
        .finished_at = "finishedAt",
        .id = "id",
        .job_driver = "jobDriver",
        .name = "name",
        .release_label = "releaseLabel",
        .retry_policy_configuration = "retryPolicyConfiguration",
        .retry_policy_execution = "retryPolicyExecution",
        .state = "state",
        .state_details = "stateDetails",
        .tags = "tags",
        .virtual_cluster_id = "virtualClusterId",
    };
};

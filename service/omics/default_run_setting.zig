const aws = @import("aws");

const CacheBehavior = @import("cache_behavior.zig").CacheBehavior;
const RunLogLevel = @import("run_log_level.zig").RunLogLevel;
const RunRetentionMode = @import("run_retention_mode.zig").RunRetentionMode;
const StorageType = @import("storage_type.zig").StorageType;
const WorkflowType = @import("workflow_type.zig").WorkflowType;

/// Shared configuration applied to all runs in a batch. Fields specified in a
/// per-run `InlineSetting` entry override the corresponding fields in this
/// object for that run. The `parameters` and `runTags` fields are merged rather
/// than replaced — run-specific values take precedence when keys overlap.
pub const DefaultRunSetting = struct {
    /// The cache behavior for the runs. Requires `cacheId` to be set.
    cache_behavior: ?CacheBehavior = null,

    /// The identifier of the run cache to associate with the runs.
    cache_id: ?[]const u8 = null,

    /// The verbosity level for CloudWatch Logs emitted during each run.
    log_level: ?RunLogLevel = null,

    /// An optional user-friendly name applied to each workflow run. Can be
    /// overridden per run.
    name: ?[]const u8 = null,

    /// The expected AWS account ID of the owner of the output S3 bucket. Can be
    /// overridden per run.
    output_bucket_owner_id: ?[]const u8 = null,

    /// The destination S3 URI for workflow outputs. Must begin with `s3://`. The
    /// `roleArn` must grant write permissions to this bucket. Can be overridden per
    /// run.
    output_uri: ?[]const u8 = null,

    /// Workflow parameter names and values shared across all runs. Merged with
    /// per-run parameters; run-specific values take precedence when keys overlap.
    /// Can be overridden per run.
    parameters: ?[]const u8 = null,

    /// An integer priority for the workflow runs. Higher values correspond to
    /// higher priority. A value of 0 corresponds to the lowest priority. Can be
    /// overridden per run.
    priority: ?i32 = null,

    /// The retention behavior for runs after completion.
    retention_mode: ?RunRetentionMode = null,

    /// The IAM role ARN that grants HealthOmics permissions to access required AWS
    /// resources such as Amazon S3 and CloudWatch. The role must have the same
    /// permissions required for individual `StartRun` calls.
    role_arn: []const u8,

    /// The ID of the run group to contain all workflow runs in the batch.
    run_group_id: ?[]const u8 = null,

    /// AWS tags to associate with each workflow run. Merged with per-run `runTags`;
    /// run-specific values take precedence when keys overlap.
    run_tags: ?[]const aws.map.StringMapEntry = null,

    /// The filesystem size in gibibytes (GiB) provisioned for each workflow run and
    /// shared by all tasks in that run. Defaults to 1200 GiB if not specified.
    storage_capacity: ?i32 = null,

    /// The storage type for the workflow runs.
    storage_type: ?StorageType = null,

    /// The identifier of the workflow to run.
    workflow_id: []const u8,

    /// The AWS account ID of the workflow owner, used for cross-account workflow
    /// sharing.
    workflow_owner_id: ?[]const u8 = null,

    /// The type of the originating workflow. Batch runs are not supported with
    /// `READY2RUN` workflows.
    workflow_type: ?WorkflowType = null,

    /// The version name of the specified workflow.
    workflow_version_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .cache_behavior = "cacheBehavior",
        .cache_id = "cacheId",
        .log_level = "logLevel",
        .name = "name",
        .output_bucket_owner_id = "outputBucketOwnerId",
        .output_uri = "outputUri",
        .parameters = "parameters",
        .priority = "priority",
        .retention_mode = "retentionMode",
        .role_arn = "roleArn",
        .run_group_id = "runGroupId",
        .run_tags = "runTags",
        .storage_capacity = "storageCapacity",
        .storage_type = "storageType",
        .workflow_id = "workflowId",
        .workflow_owner_id = "workflowOwnerId",
        .workflow_type = "workflowType",
        .workflow_version_name = "workflowVersionName",
    };
};

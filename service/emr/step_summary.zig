const ActionOnFailure = @import("action_on_failure.zig").ActionOnFailure;
const HadoopStepConfig = @import("hadoop_step_config.zig").HadoopStepConfig;
const StepStatus = @import("step_status.zig").StepStatus;

/// The summary of the cluster step.
pub const StepSummary = struct {
    /// The action to take when the cluster step fails. Possible values are
    /// TERMINATE_CLUSTER,
    /// CANCEL_AND_WAIT, and CONTINUE. TERMINATE_JOB_FLOW is available for backward
    /// compatibility.
    action_on_failure: ?ActionOnFailure,

    /// The Hadoop job configuration of the cluster step.
    config: ?HadoopStepConfig,

    /// The KMS key ARN to encrypt the logs published to the given Amazon S3
    /// destination.
    encryption_key_arn: ?[]const u8,

    /// The identifier of the cluster step.
    id: ?[]const u8,

    /// The Amazon S3 destination URI for log publishing.
    log_uri: ?[]const u8,

    /// The name of the cluster step.
    name: ?[]const u8,

    /// The current execution status details of the cluster step.
    status: ?StepStatus,

    pub const json_field_names = .{
        .action_on_failure = "ActionOnFailure",
        .config = "Config",
        .encryption_key_arn = "EncryptionKeyArn",
        .id = "Id",
        .log_uri = "LogUri",
        .name = "Name",
        .status = "Status",
    };
};

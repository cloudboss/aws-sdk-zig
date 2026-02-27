const ActionOnFailure = @import("action_on_failure.zig").ActionOnFailure;
const HadoopStepConfig = @import("hadoop_step_config.zig").HadoopStepConfig;
const StepStatus = @import("step_status.zig").StepStatus;

/// This represents a step in a cluster.
pub const Step = struct {
    /// The action to take when the cluster step fails. Possible values are
    /// `TERMINATE_CLUSTER`, `CANCEL_AND_WAIT`, and `CONTINUE`.
    /// `TERMINATE_JOB_FLOW` is provided for backward compatibility. We recommend
    /// using `TERMINATE_CLUSTER` instead.
    ///
    /// If a cluster's `StepConcurrencyLevel` is greater than `1`, do not
    /// use `AddJobFlowSteps` to submit a step with this parameter set to
    /// `CANCEL_AND_WAIT` or `TERMINATE_CLUSTER`. The step is not
    /// submitted and the action fails with a message that the `ActionOnFailure`
    /// setting
    /// is not valid.
    ///
    /// If you change a cluster's `StepConcurrencyLevel` to be greater than 1 while
    /// a
    /// step is running, the `ActionOnFailure` parameter may not behave as you
    /// expect.
    /// In this case, for a step that fails with this parameter set to
    /// `CANCEL_AND_WAIT`, pending steps and the running step are not canceled; for
    /// a
    /// step that fails with this parameter set to `TERMINATE_CLUSTER`, the cluster
    /// does
    /// not terminate.
    action_on_failure: ?ActionOnFailure,

    /// The Hadoop job configuration of the cluster step.
    config: ?HadoopStepConfig,

    /// The KMS key ARN to encrypt the logs published to the given Amazon S3
    /// destination.
    encryption_key_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the runtime role for a step on the
    /// cluster. The
    /// runtime role can be a cross-account IAM role. The runtime role ARN is a
    /// combination of account ID, role name, and role type using the following
    /// format:
    /// `arn:partition:service:region:account:resource`.
    ///
    /// For example, `arn:aws:IAM::1234567890:role/ReadOnly` is a correctly
    /// formatted
    /// runtime role ARN.
    execution_role_arn: ?[]const u8,

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
        .execution_role_arn = "ExecutionRoleArn",
        .id = "Id",
        .log_uri = "LogUri",
        .name = "Name",
        .status = "Status",
    };
};

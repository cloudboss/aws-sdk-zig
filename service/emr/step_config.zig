const ActionOnFailure = @import("action_on_failure.zig").ActionOnFailure;
const HadoopJarStepConfig = @import("hadoop_jar_step_config.zig").HadoopJarStepConfig;
const StepMonitoringConfiguration = @import("step_monitoring_configuration.zig").StepMonitoringConfiguration;

/// Specification for a cluster (job flow) step.
pub const StepConfig = struct {
    /// The action to take when the step fails. Use one of the following values:
    ///
    /// * `TERMINATE_CLUSTER` - Shuts down the cluster.
    ///
    /// * `CANCEL_AND_WAIT` - Cancels any pending steps and returns the cluster
    /// to the `WAITING` state.
    ///
    /// * `CONTINUE` - Continues to the next step in the queue.
    ///
    /// * `TERMINATE_JOB_FLOW` - Shuts down the cluster.
    /// `TERMINATE_JOB_FLOW` is provided for backward compatibility. We
    /// recommend using `TERMINATE_CLUSTER` instead.
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
    action_on_failure: ?ActionOnFailure = null,

    /// The JAR file used for the step.
    hadoop_jar_step: HadoopJarStepConfig,

    /// The name of the step.
    name: []const u8,

    /// Object that holds configuration properties for logging.
    step_monitoring_configuration: ?StepMonitoringConfiguration = null,

    pub const json_field_names = .{
        .action_on_failure = "ActionOnFailure",
        .hadoop_jar_step = "HadoopJarStep",
        .name = "Name",
        .step_monitoring_configuration = "StepMonitoringConfiguration",
    };
};

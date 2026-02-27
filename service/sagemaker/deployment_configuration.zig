const AlarmDetails = @import("alarm_details.zig").AlarmDetails;
const RollingDeploymentPolicy = @import("rolling_deployment_policy.zig").RollingDeploymentPolicy;

/// The configuration to use when updating the AMI versions.
pub const DeploymentConfiguration = struct {
    /// An array that contains the alarms that SageMaker monitors to know whether to
    /// roll back the AMI update.
    auto_rollback_configuration: ?[]const AlarmDetails,

    /// The policy that SageMaker uses when updating the AMI versions of the
    /// cluster.
    rolling_update_policy: ?RollingDeploymentPolicy,

    /// The duration in seconds that SageMaker waits before updating more instances
    /// in the cluster.
    wait_interval_in_seconds: ?i32,

    pub const json_field_names = .{
        .auto_rollback_configuration = "AutoRollbackConfiguration",
        .rolling_update_policy = "RollingUpdatePolicy",
        .wait_interval_in_seconds = "WaitIntervalInSeconds",
    };
};

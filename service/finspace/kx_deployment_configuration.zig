const KxDeploymentStrategy = @import("kx_deployment_strategy.zig").KxDeploymentStrategy;

/// The configuration that allows you to choose how you want to update the
/// databases on a cluster. Depending on the option you choose, you can reduce
/// the time it takes to update the cluster.
pub const KxDeploymentConfiguration = struct {
    /// The type of deployment that you want on a cluster.
    ///
    /// * ROLLING – This options updates the cluster by stopping the exiting q
    ///   process and starting a new q process with updated configuration.
    ///
    /// * NO_RESTART – This option updates the cluster without stopping the running
    ///   q process. It is only available for `HDB` type cluster. This option is
    ///   quicker as it reduces the turn around time to update configuration on a
    ///   cluster.
    ///
    /// With this deployment mode, you cannot update the `initializationScript` and
    /// `commandLineArguments` parameters.
    deployment_strategy: KxDeploymentStrategy,

    pub const json_field_names = .{
        .deployment_strategy = "deploymentStrategy",
    };
};

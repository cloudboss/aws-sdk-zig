const KxClusterCodeDeploymentStrategy = @import("kx_cluster_code_deployment_strategy.zig").KxClusterCodeDeploymentStrategy;

/// The configuration that allows you to choose how you want to update code on a
/// cluster. Depending on the option you choose, you can reduce the time it
/// takes to update the cluster.
pub const KxClusterCodeDeploymentConfiguration = struct {
    /// The type of deployment that you want on a cluster.
    ///
    /// * ROLLING – This options updates the cluster by stopping the exiting q
    ///   process and starting a new q process with updated configuration.
    ///
    /// * NO_RESTART – This option updates the cluster without stopping the running
    ///   q process. It is only available for `GP` type cluster. This option is
    ///   quicker as it reduces the turn around time to update configuration on a
    ///   cluster.
    ///
    /// With this deployment mode, you cannot update the `initializationScript` and
    /// `commandLineArguments` parameters.
    ///
    /// * FORCE – This option updates the cluster by immediately stopping all the
    ///   running processes before starting up new ones with the updated
    ///   configuration.
    deployment_strategy: KxClusterCodeDeploymentStrategy,

    pub const json_field_names = .{
        .deployment_strategy = "deploymentStrategy",
    };
};

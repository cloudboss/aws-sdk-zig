const ClusterSharedEnvironmentConfig = @import("cluster_shared_environment_config.zig").ClusterSharedEnvironmentConfig;

/// The configuration for the restricted instance groups (RIG) in the SageMaker
/// HyperPod cluster.
pub const ClusterRestrictedInstanceGroupsConfig = struct {
    /// The shared environment configuration for the restricted instance groups
    /// (RIG).
    shared_environment_config: ClusterSharedEnvironmentConfig,

    pub const json_field_names = .{
        .shared_environment_config = "SharedEnvironmentConfig",
    };
};

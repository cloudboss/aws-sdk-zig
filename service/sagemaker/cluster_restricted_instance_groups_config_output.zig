const ClusterSharedEnvironmentConfigDetails = @import("cluster_shared_environment_config_details.zig").ClusterSharedEnvironmentConfigDetails;

/// The output configuration for the restricted instance groups (RIG) in the
/// SageMaker HyperPod cluster.
pub const ClusterRestrictedInstanceGroupsConfigOutput = struct {
    /// The shared environment configuration details for the restricted instance
    /// groups (RIG).
    shared_environment_config: ClusterSharedEnvironmentConfigDetails,

    pub const json_field_names = .{
        .shared_environment_config = "SharedEnvironmentConfig",
    };
};

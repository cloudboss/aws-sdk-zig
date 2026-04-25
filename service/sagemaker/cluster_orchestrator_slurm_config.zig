const ClusterSlurmConfigStrategy = @import("cluster_slurm_config_strategy.zig").ClusterSlurmConfigStrategy;

/// The configuration settings for the Slurm orchestrator used with the
/// SageMaker HyperPod cluster.
pub const ClusterOrchestratorSlurmConfig = struct {
    /// The strategy for managing partitions for the Slurm configuration. Valid
    /// values are `Managed`, `Overwrite`, and `Merge`.
    slurm_config_strategy: ?ClusterSlurmConfigStrategy = null,

    pub const json_field_names = .{
        .slurm_config_strategy = "SlurmConfigStrategy",
    };
};

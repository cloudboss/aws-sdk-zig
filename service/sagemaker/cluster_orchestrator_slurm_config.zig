const ClusterAccountingDatabase = @import("cluster_accounting_database.zig").ClusterAccountingDatabase;
const ClusterSlurmConfigStrategy = @import("cluster_slurm_config_strategy.zig").ClusterSlurmConfigStrategy;

/// The configuration settings for the Slurm orchestrator used with the
/// SageMaker HyperPod cluster.
pub const ClusterOrchestratorSlurmConfig = struct {
    /// The external database that stores the Slurm accounting data for the cluster,
    /// such as job history, associations, and usage. When you omit this field,
    /// Slurm accounting uses a database on the cluster's controller node.
    ///
    /// This field is only supported for clusters using `Continuous` as the
    /// `NodeProvisioningMode`.
    accounting_database: ?ClusterAccountingDatabase = null,

    /// The strategy for managing partitions for the Slurm configuration. Valid
    /// values are `Managed`, `Overwrite`, and `Merge`.
    slurm_config_strategy: ?ClusterSlurmConfigStrategy = null,

    pub const json_field_names = .{
        .accounting_database = "AccountingDatabase",
        .slurm_config_strategy = "SlurmConfigStrategy",
    };
};

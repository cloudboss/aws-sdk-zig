const CapacitySizeConfig = @import("capacity_size_config.zig").CapacitySizeConfig;

/// The configurations that SageMaker uses when updating the AMI versions.
pub const RollingDeploymentPolicy = struct {
    /// The maximum amount of instances in the cluster that SageMaker can update at
    /// a time.
    maximum_batch_size: CapacitySizeConfig,

    /// The maximum amount of instances in the cluster that SageMaker can roll back
    /// at a time.
    rollback_maximum_batch_size: ?CapacitySizeConfig = null,

    pub const json_field_names = .{
        .maximum_batch_size = "MaximumBatchSize",
        .rollback_maximum_batch_size = "RollbackMaximumBatchSize",
    };
};

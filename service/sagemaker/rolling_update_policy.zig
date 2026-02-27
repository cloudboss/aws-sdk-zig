const CapacitySize = @import("capacity_size.zig").CapacitySize;

/// Specifies a rolling deployment strategy for updating a SageMaker endpoint.
pub const RollingUpdatePolicy = struct {
    /// Batch size for each rolling step to provision capacity and turn on traffic
    /// on the new endpoint fleet, and terminate capacity on the old endpoint fleet.
    /// Value must be between 5% to 50% of the variant's total instance count.
    maximum_batch_size: CapacitySize,

    /// The time limit for the total deployment. Exceeding this limit causes a
    /// timeout.
    maximum_execution_timeout_in_seconds: ?i32,

    /// Batch size for rollback to the old endpoint fleet. Each rolling step to
    /// provision capacity and turn on traffic on the old endpoint fleet, and
    /// terminate capacity on the new endpoint fleet. If this field is absent, the
    /// default value will be set to 100% of total capacity which means to bring up
    /// the whole capacity of the old fleet at once during rollback.
    rollback_maximum_batch_size: ?CapacitySize,

    /// The length of the baking period, during which SageMaker monitors alarms for
    /// each batch on the new fleet.
    wait_interval_in_seconds: i32,

    pub const json_field_names = .{
        .maximum_batch_size = "MaximumBatchSize",
        .maximum_execution_timeout_in_seconds = "MaximumExecutionTimeoutInSeconds",
        .rollback_maximum_batch_size = "RollbackMaximumBatchSize",
        .wait_interval_in_seconds = "WaitIntervalInSeconds",
    };
};

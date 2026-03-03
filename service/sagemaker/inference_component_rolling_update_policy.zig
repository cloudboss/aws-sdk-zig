const InferenceComponentCapacitySize = @import("inference_component_capacity_size.zig").InferenceComponentCapacitySize;

/// Specifies a rolling deployment strategy for updating a SageMaker AI
/// inference component.
pub const InferenceComponentRollingUpdatePolicy = struct {
    /// The batch size for each rolling step in the deployment process. For each
    /// step, SageMaker AI provisions capacity on the new endpoint fleet, routes
    /// traffic to that fleet, and terminates capacity on the old endpoint fleet.
    /// The value must be between 5% to 50% of the copy count of the inference
    /// component.
    maximum_batch_size: InferenceComponentCapacitySize,

    /// The time limit for the total deployment. Exceeding this limit causes a
    /// timeout.
    maximum_execution_timeout_in_seconds: ?i32 = null,

    /// The batch size for a rollback to the old endpoint fleet. If this field is
    /// absent, the value is set to the default, which is 100% of the total
    /// capacity. When the default is used, SageMaker AI provisions the entire
    /// capacity of the old fleet at once during rollback.
    rollback_maximum_batch_size: ?InferenceComponentCapacitySize = null,

    /// The length of the baking period, during which SageMaker AI monitors alarms
    /// for each batch on the new fleet.
    wait_interval_in_seconds: i32,

    pub const json_field_names = .{
        .maximum_batch_size = "MaximumBatchSize",
        .maximum_execution_timeout_in_seconds = "MaximumExecutionTimeoutInSeconds",
        .rollback_maximum_batch_size = "RollbackMaximumBatchSize",
        .wait_interval_in_seconds = "WaitIntervalInSeconds",
    };
};

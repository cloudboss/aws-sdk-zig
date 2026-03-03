/// Defines the capacity limit for a service environment. This structure
/// specifies the maximum amount of resources that can be used by service jobs
/// in the environment.
pub const CapacityLimit = struct {
    /// The unit of measure for the capacity limit. This defines how the maxCapacity
    /// value should be interpreted. For `SAGEMAKER_TRAINING` jobs, use
    /// `NUM_INSTANCES`.
    capacity_unit: ?[]const u8 = null,

    /// The maximum capacity available for the service environment. This value
    /// represents the maximum amount of resources that can be allocated to service
    /// jobs.
    ///
    /// For example, `maxCapacity=50`, `capacityUnit=NUM_INSTANCES`. This indicates
    /// that the
    /// maximum number of instances that can be run on this service environment is
    /// 50. You could
    /// then run 5 SageMaker Training jobs that each use 10 instances. However, if
    /// you submit another job that
    /// requires 10 instances, it will wait in the queue.
    max_capacity: ?i32 = null,

    pub const json_field_names = .{
        .capacity_unit = "capacityUnit",
        .max_capacity = "maxCapacity",
    };
};

/// Defines the type and maximum quantity of resources that can be allocated to
/// service jobs in a service environment.
pub const CapacityLimit = struct {
    /// The unit of measure for the capacity limit, which defines how `maxCapacity`
    /// is interpreted. For `SAGEMAKER_TRAINING` jobs in a quota management
    /// enabled service environment, specify the [instance
    /// type](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ResourceConfig.html#sagemaker-Type-ResourceConfig-InstanceType)
    /// (for example, `ml.m5.large`). Otherwise, use `NUM_INSTANCES`.
    capacity_unit: ?[]const u8 = null,

    /// The maximum capacity available for the service environment. For a quota
    /// management enabled service environment, this value represents
    /// the maximum quantity of a particular resource type (specified by
    /// `capacityUnit`) that can be allocated to service jobs.
    /// For other service environments, this value represents the maximum quantity
    /// of all resources that can be allocated to service jobs.
    ///
    /// For example, if `maxCapacity=50` and `capacityUnit=NUM_INSTANCES`, you can
    /// run up to 50 instances concurrently.
    /// If you run 5 SageMaker Training jobs that each use 10 instances, a
    /// subsequent job requiring 10 instances waits in the queue until
    /// capacity is available. In a quota management enabled service environment
    /// with `capacityUnit=ml.m5.large`, only
    /// `ml.m5.large` instances count against this limit, and jobs requiring other
    /// instance types wait until a matching capacity limit is configured.
    max_capacity: ?i32 = null,

    pub const json_field_names = .{
        .capacity_unit = "capacityUnit",
        .max_capacity = "maxCapacity",
    };
};

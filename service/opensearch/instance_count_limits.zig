/// Limits on the number of instances that can be created in OpenSearch Service
/// for a given
/// instance type.
pub const InstanceCountLimits = struct {
    /// The minimum allowed number of instances.
    maximum_instance_count: i32 = 0,

    /// The maximum allowed number of instances.
    minimum_instance_count: i32 = 0,

    pub const json_field_names = .{
        .maximum_instance_count = "MaximumInstanceCount",
        .minimum_instance_count = "MinimumInstanceCount",
    };
};

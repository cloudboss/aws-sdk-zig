/// InstanceCountLimits represents the limits on number of instances that be
/// created in Amazon Elasticsearch for
/// given InstanceType.
pub const InstanceCountLimits = struct {
    maximum_instance_count: i32 = 0,

    minimum_instance_count: i32 = 0,

    pub const json_field_names = .{
        .maximum_instance_count = "MaximumInstanceCount",
        .minimum_instance_count = "MinimumInstanceCount",
    };
};

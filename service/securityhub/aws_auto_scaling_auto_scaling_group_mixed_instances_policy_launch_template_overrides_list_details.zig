/// Property values to use to override the values in the launch template.
pub const AwsAutoScalingAutoScalingGroupMixedInstancesPolicyLaunchTemplateOverridesListDetails = struct {
    /// The instance type. For example, `m3.xlarge`.
    instance_type: ?[]const u8 = null,

    /// The number of capacity units provided by the specified instance type in
    /// terms of virtual CPUs, memory, storage, throughput, or other relative
    /// performance characteristic.
    weighted_capacity: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_type = "InstanceType",
        .weighted_capacity = "WeightedCapacity",
    };
};

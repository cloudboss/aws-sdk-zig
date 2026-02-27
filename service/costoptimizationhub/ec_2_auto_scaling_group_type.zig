pub const Ec2AutoScalingGroupType = enum {
    single_instance_type,
    mixed_instance_types,

    pub const json_field_names = .{
        .single_instance_type = "SINGLE_INSTANCE_TYPE",
        .mixed_instance_types = "MIXED_INSTANCE_TYPES",
    };
};

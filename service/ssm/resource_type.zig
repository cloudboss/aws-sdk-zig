pub const ResourceType = enum {
    managed_instance,
    ec2_instance,

    pub const json_field_names = .{
        .managed_instance = "MANAGED_INSTANCE",
        .ec2_instance = "EC2_INSTANCE",
    };
};

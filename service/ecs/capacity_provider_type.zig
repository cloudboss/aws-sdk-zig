pub const CapacityProviderType = enum {
    ec2_autoscaling,
    managed_instances,
    fargate,
    fargate_spot,

    pub const json_field_names = .{
        .ec2_autoscaling = "EC2_AUTOSCALING",
        .managed_instances = "MANAGED_INSTANCES",
        .fargate = "FARGATE",
        .fargate_spot = "FARGATE_SPOT",
    };
};

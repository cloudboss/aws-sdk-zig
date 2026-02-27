pub const LaunchType = enum {
    ec2,
    fargate,
    external,
    managed_instances,

    pub const json_field_names = .{
        .ec2 = "EC2",
        .fargate = "FARGATE",
        .external = "EXTERNAL",
        .managed_instances = "MANAGED_INSTANCES",
    };
};

pub const ResourceType = enum {
    eks,
    ecs,
    ec2,

    pub const json_field_names = .{
        .eks = "EKS",
        .ecs = "ECS",
        .ec2 = "EC2",
    };
};

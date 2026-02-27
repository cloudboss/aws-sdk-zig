pub const EcsLaunchType = enum {
    fargate,
    ec2,

    pub const json_field_names = .{
        .fargate = "FARGATE",
        .ec2 = "EC2",
    };
};

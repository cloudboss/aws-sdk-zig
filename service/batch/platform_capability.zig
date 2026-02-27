pub const PlatformCapability = enum {
    ec2,
    fargate,

    pub const json_field_names = .{
        .ec2 = "EC2",
        .fargate = "FARGATE",
    };
};

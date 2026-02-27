pub const CRType = enum {
    ec2,
    spot,
    fargate,
    fargate_spot,

    pub const json_field_names = .{
        .ec2 = "EC2",
        .spot = "SPOT",
        .fargate = "FARGATE",
        .fargate_spot = "FARGATE_SPOT",
    };
};

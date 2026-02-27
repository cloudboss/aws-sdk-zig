pub const ServiceNamespace = enum {
    autoscaling,
    ecs,
    ec2,
    rds,
    dynamodb,

    pub const json_field_names = .{
        .autoscaling = "AUTOSCALING",
        .ecs = "ECS",
        .ec2 = "EC2",
        .rds = "RDS",
        .dynamodb = "DYNAMODB",
    };
};

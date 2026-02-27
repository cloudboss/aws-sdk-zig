pub const ComputePlatform = enum {
    server,
    lambda,
    ecs,

    pub const json_field_names = .{
        .server = "SERVER",
        .lambda = "LAMBDA",
        .ecs = "ECS",
    };
};

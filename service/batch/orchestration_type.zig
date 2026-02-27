pub const OrchestrationType = enum {
    ecs,
    eks,

    pub const json_field_names = .{
        .ecs = "ECS",
        .eks = "EKS",
    };
};

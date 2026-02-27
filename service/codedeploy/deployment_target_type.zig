pub const DeploymentTargetType = enum {
    instance_target,
    lambda_target,
    ecs_target,
    cloudformation_target,

    pub const json_field_names = .{
        .instance_target = "INSTANCE_TARGET",
        .lambda_target = "LAMBDA_TARGET",
        .ecs_target = "ECS_TARGET",
        .cloudformation_target = "CLOUDFORMATION_TARGET",
    };
};

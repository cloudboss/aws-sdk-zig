pub const DeploymentControllerType = enum {
    ecs,
    code_deploy,
    external,

    pub const json_field_names = .{
        .ecs = "ECS",
        .code_deploy = "CODE_DEPLOY",
        .external = "EXTERNAL",
    };
};

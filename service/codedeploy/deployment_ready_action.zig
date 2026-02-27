pub const DeploymentReadyAction = enum {
    continue_deployment,
    stop_deployment,

    pub const json_field_names = .{
        .continue_deployment = "CONTINUE_DEPLOYMENT",
        .stop_deployment = "STOP_DEPLOYMENT",
    };
};

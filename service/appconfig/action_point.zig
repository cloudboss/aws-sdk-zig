pub const ActionPoint = enum {
    pre_create_hosted_configuration_version,
    pre_start_deployment,
    at_deployment_tick,
    on_deployment_start,
    on_deployment_step,
    on_deployment_baking,
    on_deployment_complete,
    on_deployment_rolled_back,

    pub const json_field_names = .{
        .pre_create_hosted_configuration_version = "PRE_CREATE_HOSTED_CONFIGURATION_VERSION",
        .pre_start_deployment = "PRE_START_DEPLOYMENT",
        .at_deployment_tick = "AT_DEPLOYMENT_TICK",
        .on_deployment_start = "ON_DEPLOYMENT_START",
        .on_deployment_step = "ON_DEPLOYMENT_STEP",
        .on_deployment_baking = "ON_DEPLOYMENT_BAKING",
        .on_deployment_complete = "ON_DEPLOYMENT_COMPLETE",
        .on_deployment_rolled_back = "ON_DEPLOYMENT_ROLLED_BACK",
    };
};

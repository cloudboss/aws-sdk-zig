pub const EnvironmentState = enum {
    ready_for_deployment,
    deploying,
    rolling_back,
    rolled_back,
    reverted,

    pub const json_field_names = .{
        .ready_for_deployment = "READY_FOR_DEPLOYMENT",
        .deploying = "DEPLOYING",
        .rolling_back = "ROLLING_BACK",
        .rolled_back = "ROLLED_BACK",
        .reverted = "REVERTED",
    };
};

pub const DeploymentState = enum {
    baking,
    validating,
    deploying,
    complete,
    rolling_back,
    rolled_back,
    reverted,

    pub const json_field_names = .{
        .baking = "BAKING",
        .validating = "VALIDATING",
        .deploying = "DEPLOYING",
        .complete = "COMPLETE",
        .rolling_back = "ROLLING_BACK",
        .rolled_back = "ROLLED_BACK",
        .reverted = "REVERTED",
    };
};

pub const DeploymentStrategy = enum {
    rolling,
    blue_green,
    linear,
    canary,

    pub const json_field_names = .{
        .rolling = "ROLLING",
        .blue_green = "BLUE_GREEN",
        .linear = "LINEAR",
        .canary = "CANARY",
    };
};

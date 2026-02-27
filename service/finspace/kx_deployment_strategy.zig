pub const KxDeploymentStrategy = enum {
    no_restart,
    rolling,

    pub const json_field_names = .{
        .no_restart = "NO_RESTART",
        .rolling = "ROLLING",
    };
};

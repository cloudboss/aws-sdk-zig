pub const KxClusterCodeDeploymentStrategy = enum {
    no_restart,
    rolling,
    force,

    pub const json_field_names = .{
        .no_restart = "NO_RESTART",
        .rolling = "ROLLING",
        .force = "FORCE",
    };
};

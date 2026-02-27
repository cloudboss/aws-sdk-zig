pub const DeploymentImpairmentStrategy = enum {
    maintain,
    rollback,

    pub const json_field_names = .{
        .maintain = "MAINTAIN",
        .rollback = "ROLLBACK",
    };
};

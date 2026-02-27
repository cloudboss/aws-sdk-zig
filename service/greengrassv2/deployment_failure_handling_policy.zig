pub const DeploymentFailureHandlingPolicy = enum {
    rollback,
    do_nothing,

    pub const json_field_names = .{
        .rollback = "ROLLBACK",
        .do_nothing = "DO_NOTHING",
    };
};

pub const ContainerDependencyCondition = enum {
    start,
    complete,
    success,
    healthy,

    pub const json_field_names = .{
        .start = "START",
        .complete = "COMPLETE",
        .success = "SUCCESS",
        .healthy = "HEALTHY",
    };
};

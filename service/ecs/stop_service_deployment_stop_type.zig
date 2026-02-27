pub const StopServiceDeploymentStopType = enum {
    abort,
    rollback,

    pub const json_field_names = .{
        .abort = "ABORT",
        .rollback = "ROLLBACK",
    };
};

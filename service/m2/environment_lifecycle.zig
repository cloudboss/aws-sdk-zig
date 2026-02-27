pub const EnvironmentLifecycle = enum {
    creating,
    available,
    updating,
    deleting,
    failed,
    unhealthy,

    pub const json_field_names = .{
        .creating = "CREATING",
        .available = "AVAILABLE",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .failed = "FAILED",
        .unhealthy = "UNHEALTHY",
    };
};

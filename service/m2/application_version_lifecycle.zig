pub const ApplicationVersionLifecycle = enum {
    creating,
    available,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .available = "AVAILABLE",
        .failed = "FAILED",
    };
};

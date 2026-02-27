pub const ExecutorState = enum {
    creating,
    created,
    registered,
    terminating,
    terminated,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .created = "CREATED",
        .registered = "REGISTERED",
        .terminating = "TERMINATING",
        .terminated = "TERMINATED",
        .failed = "FAILED",
    };
};

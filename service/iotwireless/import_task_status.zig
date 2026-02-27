pub const ImportTaskStatus = enum {
    initializing,
    initialized,
    pending,
    complete,
    failed,
    deleting,

    pub const json_field_names = .{
        .initializing = "INITIALIZING",
        .initialized = "INITIALIZED",
        .pending = "PENDING",
        .complete = "COMPLETE",
        .failed = "FAILED",
        .deleting = "DELETING",
    };
};

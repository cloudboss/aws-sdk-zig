pub const FileCacheLifecycle = enum {
    available,
    creating,
    deleting,
    updating,
    failed,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .creating = "CREATING",
        .deleting = "DELETING",
        .updating = "UPDATING",
        .failed = "FAILED",
    };
};

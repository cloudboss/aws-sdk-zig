pub const DataRepositoryLifecycle = enum {
    creating,
    available,
    misconfigured,
    updating,
    deleting,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .available = "AVAILABLE",
        .misconfigured = "MISCONFIGURED",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .failed = "FAILED",
    };
};

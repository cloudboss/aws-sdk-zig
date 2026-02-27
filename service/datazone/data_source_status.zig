pub const DataSourceStatus = enum {
    creating,
    failed_creation,
    ready,
    updating,
    failed_update,
    running,
    deleting,
    failed_deletion,

    pub const json_field_names = .{
        .creating = "CREATING",
        .failed_creation = "FAILED_CREATION",
        .ready = "READY",
        .updating = "UPDATING",
        .failed_update = "FAILED_UPDATE",
        .running = "RUNNING",
        .deleting = "DELETING",
        .failed_deletion = "FAILED_DELETION",
    };
};

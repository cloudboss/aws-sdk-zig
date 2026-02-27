pub const DataSourceStatus = enum {
    pending_creation,
    creating,
    active,
    deleting,
    failed,
    updating,

    pub const json_field_names = .{
        .pending_creation = "PENDING_CREATION",
        .creating = "CREATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .failed = "FAILED",
        .updating = "UPDATING",
    };
};

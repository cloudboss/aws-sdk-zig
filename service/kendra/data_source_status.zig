pub const DataSourceStatus = enum {
    creating,
    deleting,
    failed,
    updating,
    active,

    pub const json_field_names = .{
        .creating = "CREATING",
        .deleting = "DELETING",
        .failed = "FAILED",
        .updating = "UPDATING",
        .active = "ACTIVE",
    };
};

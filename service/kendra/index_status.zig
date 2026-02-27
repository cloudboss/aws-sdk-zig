pub const IndexStatus = enum {
    creating,
    active,
    deleting,
    failed,
    updating,
    system_updating,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .failed = "FAILED",
        .updating = "UPDATING",
        .system_updating = "SYSTEM_UPDATING",
    };
};

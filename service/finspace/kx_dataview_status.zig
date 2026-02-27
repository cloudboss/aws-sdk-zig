pub const KxDataviewStatus = enum {
    creating,
    active,
    updating,
    failed,
    deleting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .failed = "FAILED",
        .deleting = "DELETING",
    };
};

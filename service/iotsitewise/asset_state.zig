pub const AssetState = enum {
    creating,
    active,
    updating,
    deleting,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .failed = "FAILED",
    };
};

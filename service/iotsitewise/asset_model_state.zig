pub const AssetModelState = enum {
    creating,
    active,
    updating,
    propagating,
    deleting,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .propagating = "PROPAGATING",
        .deleting = "DELETING",
        .failed = "FAILED",
    };
};

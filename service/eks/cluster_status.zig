pub const ClusterStatus = enum {
    creating,
    active,
    deleting,
    failed,
    updating,
    pending,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .failed = "FAILED",
        .updating = "UPDATING",
        .pending = "PENDING",
    };
};

pub const PortalState = enum {
    creating,
    pending,
    updating,
    deleting,
    active,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .pending = "PENDING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .active = "ACTIVE",
        .failed = "FAILED",
    };
};
